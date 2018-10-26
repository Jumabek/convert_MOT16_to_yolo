# convert_MOT16_to_yolo
This repo contains script that will convert MOT 16 and MOT 17 annotations to YOLO format,
Since MOT17 has the same images as MOT16 but improved and more accurate annotation, I recommend using MOT17.


<h1>How to use script?</h1>
<ul>
<li>  Change the 'dataset_root' in convert_to_yolo.m to point to your MOT17/MOT16 location. </li>
<li>  Run convert_to_yolo from matlab </li>
</ul>

<h1>Outputs</h1>
<ul>
<li> You will get yolo format annotations in 'labels' folder</li>
<li> You can also get images with drawn bboxes in 'drawn_img' folder by setting 'VISUALIZE=1' in convert_to_yolo.m </li>
</ul>

<h3>Note </h3>
 I converted pedestrian, person_on_vehicle and static_person as a positive class (labeled as 0). Distraction and reflection classes are converted as don't-know class (labeled as '-1'). You should customize YOLO to ignore examples with '-1' class while computing the loss. 

Note '-1' class is neither negative nor a positive class. Hence, we should ignore those kinds of objects when computing the loss/cost-function.


<h1>What is MOT16/17?</h1>

MOT17 Det is a dataset for people detection challenge from MOT  (https://motchallenge.net/data/MOT17Det/). It contains 14 videos under different lighting, view, weather conditions, 7 of them are training set and another 7 are used as test set. This dataset, MOT 17Det is the improved version of MOT 16 (https://arxiv.org/pdf/1603.00831.pdf).



<h3> Dataset Statistics </h3>

According to https://arxiv.org/pdf/1603.00831.pdf, MOT 16 contains ~320,000 person annotations (Pedestrian + person_on_vehicle + static_person) Table 3.  It also contains distractor class(statues, mannikin) and reflection class(reflection of people in the mirror). These two classes could be ignored by detector, for example, if detector detects them we do not say it is false detection and if detector misses them, we do not say misdetection. That way detector can learn from only 'clean' annotations. 

<img src="https://image.ibb.co/daOXFk/Table3.png" alt="Table3" border="0">


This dataset annotation is diferent from YOLO annotations in three ways:
<ul>
<li>It contains whole video annotation in a single file </li>
<li>It contains 12 classes </li>
<li>Its annotations are in [frm_id,seq_id,xmin,ymin,w,h,confidence,class,visibility] and not in [relative_x, relative_y, relative_w, relative_h] format </li>
</ul>

