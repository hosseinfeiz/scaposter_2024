#!/bin/bash

# List of images to resize
image_list=(
    "image1.png"
    "image2.png"
    "image3.png"
    "image4.png"
    "image5.png"
    "image6.png"
    "image7.png"
    "image8.png"
)

# Desired size
new_size="350x1250!"

# Folder containing images (optional, if images are in the same directory as the script, no need to change this)
image_folder="."  # Replace with the path to your images, or leave it empty if in the same folder

for image_name in "${image_list[@]}"; do
    if [[ -n "$image_folder" ]]; then
        image_path="$image_folder/$image_name"
    else
        image_path="$image_name"
    fi

    # Resize the image
    magick "$image_path" -resize "$new_size" "$image_path"
done

echo "All images have been resized to $new_size."