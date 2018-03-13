<?php

//namespace Reinink\Magick;

/*
 * // Create Magick instance
	$magick = new Magick();

	// Set the path to the file you want to modify
	$magick->setFilePath('original.jpg');

	// Create an extra large version
	// Restricted to a maximum of 1200px high
	$magick->setHeight(1200)->convert('xlarge.jpg');

	// Create a large version
	// Set a specific cropping ratio
	// Set height to null (to clear the 1200px restriction)
	// Add new width restriction of 1175px wide
	$magick->setCropByRatio(1175/660)->setHeight(null)->setWidth(1175)->convert('large.jpg');

	// Create a medium version
	// Adjust the crop ratio
	// Set a smaller width restriction of 750px
	$magick->setCropByRatio(750/500)->setWidth(750)->convert('medium.jpg');

	// Create a small version
	// Set a smaller width restriction of 250px
	$magick->setWidth(250)->convert('small.jpg');

	// Create an extra small version
	// Set the crop ratio as a square
	// Set a small width restriction of 75px
	$magick->setCropByRatio(1)->setWidth(75)->convert('xsmall.jpg');
 */


class Domain_Magick
{
    /**
     * The convert command path.
     *
     * @var string
     */
    private $convert_path;

    /**
     * The source image path.
     *
     * @var string
     */
    private $file_path;

    /**
     * The convert crop command.
     *
     * @var int,string
     */
    private $crop;

    /**
     * The convert width in pixels.
     *
     * @var int
     */
    private $width;

    /**
     * The convert height in pixels.
     *
     * @var int
     */
    private $height;

    /**
     * The convert quality.
     *
     * @var int
     */
    private $quality = 90;

    /**
     * Create a new Magick instance.
     *
     * @param  string $convert_path
     * @return void
     */
    public function __construct($convert_path = 'convert')
    {
        $this->convert_path = $convert_path;
    }

    /**
     * Set the convert command path.
     *
     * @param  string $convert_path
     * @return Magick
     */
    public function setConvertPath($convert_path)
    {
        $this->convert_path = $convert_path;

        return $this;
    }

    /**
     * Set the source image path.
     *
     * @param  string $file_path
     * @return Magick
     */
    public function setFilePath($file_path)
    {
        $this->file_path = $file_path;

        return $this;
    }

    /**
     * Set the convert cropping by ratio with optional gravity parameter.
     *
     * <code>
     *      $image->set_crop(16/9);
     * </code>
     *
     * @param  int    $width
     * @param  string $gravity
     * @return Magick
     */
    public function setCropByRatio($ratio, $gravity = 'center')
    {
        // Get original image size
        $size = getimagesize($this->file_path);

        // Set dimensions
        $width = $size[0];
        $height = $width / $ratio;

        // Update dimensions if out of document bounds
        if ($height > $size[1]) {
            $width = $size[1] * $ratio;
            $height = $size[1];
        }

        // Build crop command
        $this->crop = ' -gravity ' . $gravity . ' -extent ' . $width . 'x' . $height;

        return $this;
    }

    /**
     * Set the convert cropping by coordinates.
     *
     * @param  int    $width
     * @param  int    $height
     * @param  int    $x_pos
     * @param  int    $y_pos
     * @return Magick
     */
    public function setCropByCoordinates($width, $height, $x_pos, $y_pos)
    {
        $this->crop = ' -crop ' . $width . 'x' . $height . '+' . $x_pos . '+' . $y_pos;

        return $this;
    }

    /**
     * Disable cropping.
     *
     * @return Magick
     */
    public function disableCrop()
    {
        $this->crop = null;

        return $this;
    }

    /**
     * Set the convert width in pixels.
     *
     * @param  int    $width
     * @return Magick
     */
    public function setWidth($width)
    {
        $this->width = $width;

        return $this;
    }

    /**
     * Set the convert height in pixels.
     *
     * @param  int    $height
     * @return Magick
     */
    public function setHeight($height)
    {
        $this->height = $height;

        return $this;
    }

    /**
     * Set the convert quality.
     *
     * @param  int    $quality
     * @return Magick
     */
    public function setQuality($quality)
    {
        $this->quality = $quality;

        return $this;
    }

    /**
     * Generate a new image by executing the convert command.
     *
     * @param  string $dest_path
     * @return bool
     */
    public function convert($dest_path)
    {
        // Has convert path been set?
        if (is_null($this->convert_path)) {
            return false;
        }

        // Does the file exist?
        if (!is_file($this->file_path)) {
            return false;
        }

        // Run command
        exec($this->command($dest_path));

        // Return success
        return is_file($dest_path);
    }

    /**
     * Build the convert command using the current object parameters.
     *
     * @param  string $dest_path
     * @return string
     */
    private function command($dest_path)
    {
        // Convert command
        $command = $this->convert_path;

        // Auto-rotate and flatten
        $command .= ' -background white -flatten -auto-orient';

        // Source path
        $command .= ' ' . $this->file_path;

        // Crop
        if (!is_null($this->crop)) {
            $command .= $this->crop;
        }

        // Resize
        if (!is_null($this->width) and !is_null($this->height)) {
            $command .= ' -resize ' . $this->width . 'x' . $this->height;
        } elseif (!is_null($this->width) and is_null($this->height)) {
            $command .= ' -resize ' . $this->width;
        } elseif (is_null($this->width) and !is_null($this->height)) {
            $command .= ' -resize x' . $this->height;
        }

        // Image quality
        $command .= ' -quality ' . $this->quality;

        // Destination path
        $command .= ' ' . $dest_path;

        // Return command
        return $command;
    }
}
