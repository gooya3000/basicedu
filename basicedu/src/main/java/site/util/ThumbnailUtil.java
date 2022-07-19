package site.util;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;

import javax.imageio.ImageIO;

import org.imgscalr.Scalr;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ThumbnailUtil {

	static Logger log = LoggerFactory.getLogger(ThumbnailUtil.class);

	public static void thumbnailImg(String path, String fileName) {
		try {
			log.debug("path : " + path + ", fileName : " + fileName);
			BufferedImage img = ImageIO.read(new File(path + fileName));
			String ext = fileName.split("\\.")[1];

			BufferedImage thumb = Scalr.resize(img, Scalr.Method.AUTOMATIC, Scalr.Mode.FIT_TO_WIDTH, 250);
			ImageIO.write(thumb, ext, new File(path + "/thumb/" + fileName));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
