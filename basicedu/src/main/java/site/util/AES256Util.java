package site.util;

import org.apache.tomcat.util.codec.binary.Base64;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.crypto.Cipher;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.security.Key;

public class AES256Util {

	static Logger log = LoggerFactory.getLogger(AES256Util.class);

	static String iv;
	static Key keySpec;

	final static String key = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

	public AES256Util() {
		try {
			this.iv = key.substring(0, 16);
			byte[] keyBytes = new byte[16];
			byte[] b = key.getBytes("UTF-8");
			int len = b.length;
			if (len > keyBytes.length) {
				len = keyBytes.length;
			}
			System.arraycopy(b, 0, keyBytes, 0, len);

			SecretKeySpec keySpec = new SecretKeySpec(keyBytes, "AES");
			this.keySpec = keySpec;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static String encrypt(String str) {
		String encStr = "";
		try {
			Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
			c.init(Cipher.ENCRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
			byte[] encrypted = c.doFinal(str.getBytes("UTF-8"));

			encStr = new String(Base64.encodeBase64(encrypted));
			log.debug("str : " + str + ", encStr : " + encStr);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return encStr;
	}

	public String decrypt(String str) {
		String decStr = "";
		try {
			Cipher c = Cipher.getInstance("AES/CBC/PKCS5Padding");
			c.init(Cipher.DECRYPT_MODE, keySpec, new IvParameterSpec(iv.getBytes()));
			byte[] byteStr = Base64.decodeBase64(str.getBytes());

			decStr = new String(c.doFinal(byteStr), "UTF-8");
			log.debug("str : " + str + ", decStr : " + decStr);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return decStr;
	}
}
