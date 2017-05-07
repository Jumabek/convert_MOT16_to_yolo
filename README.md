# convert_MOT16_to_yolo
This repo contains script that will convert MOT16 annotations to YOLO format,
Since MOT17 has the same images as MOT16 but improved and more accurate annotation, I recommend using MOT17.


How to use script?
1. Change the 'dataset_root' in convert_to_yolo.m to point to your MOT17/MOT16 location.
2. Run convert_to_yolo from matlab

Outputs
1. You will get yolo format annotations in 'labels' folder
2. You can also get images with drawn bboxes in 'drawn_img' folder by setting 'VISUALIZE=1' in convert_to_yolo.m 



