package ReadExcel;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import jxl.Sheet;
import jxl.Workbook;
import jxl.WorkbookSettings;
import jxl.read.biff.BiffException;
import jxl.Range;

public class ReadExcel {

	private static Workbook wb;

	public ReadExcel(String excelPath) {
		try {
			wb = Workbook.getWorkbook(new File(excelPath));
			WorkbookSettings wbSettings = new WorkbookSettings();
			wbSettings.setSuppressWarnings(true);
		} catch (BiffException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		ReadExcel re = new ReadExcel("/Users/shawn/Documents/workspace/KiwiList/WebContent/总表.xls");
		HashMap<String, Integer> titleMap = re.getTitleMap(0);
		HashMap<String, ArrayList<HashMap<String, String>>> listMap = re.getDetailMap("Cost", 2, titleMap);

		System.out.println(listMap.keySet());
		System.out.println(listMap.get("全部产品").size());
		re.closeExcel();
	}

	public HashMap<String, Integer> getTitleMap(int rowNum) {
		HashMap<String, Integer> titleMap = new HashMap<String, Integer>();

		Sheet sheet = wb.getSheet("Cost");

		Range[] rangeCell = sheet.getMergedCells();

		for (int j = 0; j < sheet.getColumns(); j++) {

			String str = null;
			str = sheet.getCell(j, rowNum).getContents();
			for (Range r : rangeCell) {
				if (rowNum > r.getTopLeft().getRow() && rowNum <= r.getBottomRight().getRow()
						&& j >= r.getTopLeft().getColumn() && j <= r.getBottomRight().getColumn()) {
					str = sheet.getCell(r.getTopLeft().getColumn(), r.getTopLeft().getRow()).getContents();
				}
			}
			titleMap.put(str, j);

		}
		return titleMap;
	}

	public HashMap<String, ArrayList<HashMap<String, String>>> getDetailMap(String sheetName, int rowNumStart,
			HashMap<String, Integer> titleMap) {

		// 存储所有结果列表key：类别，value：对应类别的详情list
		HashMap<String, ArrayList<HashMap<String, String>>> listMap = new HashMap<String, ArrayList<HashMap<String, String>>>();
		// 根据类别存储
		ArrayList<HashMap<String, String>> productListWithCategory = new ArrayList<HashMap<String, String>>();
		// 全部产品列表
		ArrayList<HashMap<String, String>> productListAll = new ArrayList<HashMap<String, String>>();
		// 根据热销存储
		ArrayList<HashMap<String, String>> productListWithOnSale = new ArrayList<HashMap<String, String>>();
		// 根据断货存储
		ArrayList<HashMap<String, String>> productListWithOutOfStock = new ArrayList<HashMap<String, String>>();
		// 根据促销存储
		ArrayList<HashMap<String, String>> productListWithDiscount = new ArrayList<HashMap<String, String>>();
		boolean addItem = false;

		try {

			Sheet sheet = wb.getSheet(sheetName);
			Range[] rangeCell = sheet.getMergedCells();

			for (int i = rowNumStart; i < sheet.getRows(); i++) {
				HashMap<String, String> productMap = new HashMap<String, String>();
				for (String key : titleMap.keySet()) {

					int col = titleMap.get(key);

					String content = null;
					content = sheet.getCell(col, i).getContents();
					for (Range r : rangeCell) {
						if (i > r.getTopLeft().getRow() && i <= r.getBottomRight().getRow()
								&& col >= r.getTopLeft().getColumn() && col <= r.getBottomRight().getColumn()) {
							content = sheet.getCell(r.getTopLeft().getColumn(), r.getTopLeft().getRow()).getContents();
						}
					}

					if (!content.equals("") && sheet.getCell(col, i).getType().toString().equals("Numerical Formula")) {

						double d = Double.parseDouble(content);
						content = String.format("%.2f", Math.ceil(d));
					}

					productMap.put(key, content);
					if (key.equals("类别") && !content.equals("")) {
						addItem = true;

						if (!listMap.keySet().contains(content)) {
							productListWithCategory = new ArrayList<HashMap<String, String>>();
						}

					}
				}
				if (addItem) {
					productListAll.add(productMap);
					productListWithCategory.add(productMap);
					String remark = productMap.get("备注");
					if(remark.contains("超值")){
						productListWithDiscount.add(productMap);
					}
					if(remark.contains("热门")){
						productListWithOnSale.add(productMap);
					}
					if(remark.contains("缺货")){
						productListWithOutOfStock.add(productMap);
					}
					
					listMap.put(productMap.get("类别"), productListWithCategory);
					addItem = false;
				}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		listMap.put("全部产品", productListAll);
		listMap.put("只看热销", productListWithOnSale);
		listMap.put("只看特价", productListWithDiscount);
		listMap.put("只看缺货", productListWithOutOfStock);
		
		return listMap;
	}

	public void closeExcel() {
		wb.close();
	}
}
