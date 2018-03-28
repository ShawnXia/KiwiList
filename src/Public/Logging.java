package Public;

import java.io.UnsupportedEncodingException;
import java.text.DateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

public class Logging implements Runnable {
	private HttpServletRequest request = null;
	private String page = null;

	public Logging(HttpServletRequest request,String page) {
		this.request = request;
		this.page = page;
	}

	@Override
	public void run() {
		// TODO Auto-generated method stub
		try {
			String ip = this.getIpAddr(request);
			String datetime = this.getTimeNow();
			String address = IPLogging.getAddresses("ip=" + ip, "utf-8");

			System.out.println("time : "+datetime+ "    " +"page : "+page+ "   "+"ip : " +ip +"   "+address);
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public String getTimeNow() {
		Date now = new Date();

		DateFormat d1 = DateFormat.getDateTimeInstance();

		return d1.format(now);
	}

	public String getIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("x-forwarded-for");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

}
