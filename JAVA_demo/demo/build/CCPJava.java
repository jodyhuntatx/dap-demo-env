import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Base64;
import java.io.UnsupportedEncodingException;

public class CCPJava {

  /******************************************************************
   * 			PUBLIC MEMBERS
   *
   *
   ******************************************************************/

	// ===============================================================
	// void initJavaKeyStore() - opens Java key store containing server cert
	//
	public static void initJavaKeyStore(String _jksFile, String _jksPassword) {
	  System.setProperty("javax.net.ssl.trustStore", _jksFile);
	  System.setProperty("javax.net.ssl.trustStorePassword", _jksPassword);
	  System.setProperty("javax.net.ssl.trustStoreType", "JKS");
	}

	// ===============================================================
	//
	public static String variableValue(String _varId) {
	  String authHeader = "Token token=\"" + dapAccessToken + "\"";
	  String requestUrl = CCPUrl;
	  try {
		requestUrl = requestUrl + "/secrets/" + dapAccount 
				+ "/variable/" + URLEncoder.encode(_varId, "UTF-8");
  	  	// System.out.println("Variable requestUrl: " + requestUrl);
	  } catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	  }
	  return httpGet(requestUrl, authHeader);
        }

  /******************************************************************
   * 			PRIVATE MEMBERS
   ******************************************************************/

	 static private String CCPUrl;

	// ===============================================================
	// String httpGet() -
	//
        private static String httpGet(String url_string, String auth_header) {
	  String output = "";
	  try {
		URL url = new URL(url_string);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setRequestMethod("GET");
		conn.setRequestProperty("Accept", "application/json");
		conn.setRequestProperty("Authorization", auth_header);

		if (conn.getResponseCode() != 200) {
			throw new RuntimeException("Failed : HTTP error code : "
					+ conn.getResponseCode());
		}

		BufferedReader br = new BufferedReader(new InputStreamReader(
			(conn.getInputStream())));

		output = br.readLine();
		String tmp; 
		while ((tmp = br.readLine()) != null) {
			output = output + System.lineSeparator() + tmp;
		}

		conn.disconnect();

	  } catch (MalformedURLException e) {
		e.printStackTrace();
	  } catch (IOException e) {
		e.printStackTrace();
	  }

	  return output;

	} // httpGet()


	// ===============================================================
	// String httpPost() -
	//
        private static String httpPost(String url_string, String bodyContent) {
	  String output = "";
	  try {
	  	URL url = new URL(url_string);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();
		conn.setDoOutput(true);
		conn.setRequestMethod("POST");
		conn.setRequestProperty("Content-Type", "application/json");

		OutputStream os = conn.getOutputStream();
		os.write(bodyContent.getBytes());
		os.flush();

		if (conn.getResponseCode() != 200) {
			throw new RuntimeException("Failed : HTTP error code : "
					+ conn.getResponseCode());
		}

		BufferedReader br = new BufferedReader(new InputStreamReader(
				(conn.getInputStream())));

		String tmp;
		while ((tmp = br.readLine()) != null) {
			output = output + tmp;
		}

		conn.disconnect();

	  } catch (MalformedURLException e) {
		e.printStackTrace();
	  } catch (IOException e) {
		e.printStackTrace();
	 }

	 return output;

	} // httpPost()

	// ===============================================================
	// String base64Encode() - base64 encodes argument and returns encoded string
	//
	private static String base64Encode(String input) {
	  String encodedString = "";
	  try {
	    encodedString = Base64.getEncoder().encodeToString(input.getBytes("utf-8"));
	  } catch (UnsupportedEncodingException e) {
		e.printStackTrace();
	  }
	  return encodedString;
	} // base64Encode

} // DAPJava
