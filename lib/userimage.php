<?php
require_once("base.php");
class Identicon {

	private $hash;
	private $color;
	private $size;
	private $pixelRatio;
	private $arrayOfSquare = array();
	
	public function setSize($size) {
		$this->size = $size;
		$this->pixelRatio = round($size / 5);

		return $this;
	}

	public function getSize() {
		return $this->size;
	}

	public function setString($string) {
		if (null === $string) {
			throw new \Exception('The string cannot be null.');
		}

		$this->hash = md5($string);

		$this->convertHashToArrayOfBoolean();

		return $this;
	}

	public function getHash() {
		return $this->hash;
	}

	private function convertHashToArrayOfBoolean() {
		preg_match_all('/(\w)(\w)/', $this->hash, $chars);
		foreach ($chars[1] as $i => $char) {
			if ($i % 3 == 0) {
				$this->arrayOfSquare[$i/3][0] = $this->convertHexaToBoolean($char);
				$this->arrayOfSquare[$i/3][4] = $this->convertHexaToBoolean($char);
			} elseif ($i % 3 == 1) {
				$this->arrayOfSquare[$i/3][1] = $this->convertHexaToBoolean($char);
				$this->arrayOfSquare[$i/3][3] = $this->convertHexaToBoolean($char);
			} else {
				$this->arrayOfSquare[$i/3][2] = $this->convertHexaToBoolean($char);
			}
			ksort($this->arrayOfSquare[$i/3]);
		}

		$this->color[0] = hexdec(array_pop($chars[1]))*16;
		$this->color[1] = hexdec(array_pop($chars[1]))*16;
		$this->color[2] = hexdec(array_pop($chars[1]))*16;

		return $this;
	}

	private function convertHexaToBoolean($hexa) {
		return (bool) intval(round(hexdec($hexa)/10));
	}

	public function getArrayOfSquare() {
		return $this->arrayOfSquare;
	}

	public function generateImage($string, $size, $color) {
		$this->setString($string);
		$this->setSize($size);

		// prepare the image
		$image = imagecreatetruecolor($this->pixelRatio * 5, $this->pixelRatio * 5);
		$background = imagecolorallocate($image, 0, 0, 0);
		imagecolortransparent($image, $background);

		// prepage the color
		if (null !== $color) {
			$this->setColor($color);
		}
		$color = imagecolorallocate($image, $this->color[0], $this->color[1], $this->color[2]);

		// draw the content
		foreach ($this->arrayOfSquare as $lineKey => $lineValue) {
			foreach ($lineValue as $colKey => $colValue) {
				if (true === $colValue) {
					imagefilledrectangle($image, $colKey * $this->pixelRatio, $lineKey * $this->pixelRatio, ($colKey + 1) * $this->pixelRatio, ($lineKey + 1) * $this->pixelRatio, $color);
				}
			}
		}

		imagepng($image);
	}

	public function setColor($color) {
		if (is_array($color)) {
			$this->color[0] = $color[0];
			$this->color[1] = $color[1];
			$this->color[2] = $color[2];
		} else {
			if (false !== strpos($color, '#')) {
				$color = substr($color, 1);
			}
			$this->color[0] = hexdec(substr($color, 0, 2));
			$this->color[1] = hexdec(substr($color, 2, 2));
			$this->color[2] = hexdec(substr($color, 4, 2));
		}

		return $this;
	}

	public function getColor() {
		return $this->color;
	}

	public function displayImage($string, $size = 256, $hexaColor = null) {
		header("Content-Type: image/png");
		$this->generateImage($string, $size, $hexaColor);
	}

	public function getImageData($string, $size = 256, $hexaColor = null) {
		ob_start();
		$this->generateImage($string, $size, $hexaColor);
		$imageData = ob_get_contents();
		ob_end_clean();

		return $imageData;
	}

	public function getImageDataUri($string, $size = 256, $hexaColor = null) {
		return sprintf('data:image/png;base64,%s', base64_encode($this->getImageData($string, $size, $hexaColor)));
	}
}
$data = $db->where("id", $_GET["user"])->get("users", 1);
$email = "yoeori@live.nl";
$default = "https://yoerio.djoamersfoort.nl/lib/userimage.php?user=1&force=ident";
$size = 40;

$ident = new Identicon();
header("Content-Type: image/png");
$ident->generateImage(md5($_GET["user"]), 256, null);