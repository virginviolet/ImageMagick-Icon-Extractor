# ImageMagick-Icon-Extractor
ICO is a container format that can contain multiple icons.

This is a batch script to extract icons from ICO files, and optionally convert them to any format.

## Installation

1. Install ImageMagick, if you haven't already.
2. Download extract_icons.bat to any folder.
3. (Optional) If you want to be able to use this script in the command line from any folder like a normal program, add the script's folder to your Path environment variable.

## Usage

Run the script in a command prompt.

Usage: `extract_icons {input_file} [outfiles_format]`

`{input_file}` is the file you want to extract from.

`[outfiles_format]`: Optional parameter. If you want to convert all icons to a perticular format, specify it here, after `{input_file}`. If not specified, the icons will only be extracted, not converted.

## Issues

If ImageMagick gives you an error, it might be that the file only contains one icon.

As a fallback, you might want to convert the file instead: `magick {input_file} {output_file}`

Example: `magick my_icon.ico my_icon_converted.png`

## Assembling ICO

If you want to put one or multiple images into an ICO container (assemble into one ICO file):
1. Put all pictures alone in one folder.
2. In that directory, run `magick * {output_file}`
