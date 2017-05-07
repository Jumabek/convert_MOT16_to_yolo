
function y = draw_bbox(I,bbox,class)
    [height,width,channel] = size(I);
    %imshow(I);
    person_class = [1,2,7];
    
    xmin = int64(bbox.xmin);
    ymin = int64(bbox.ymin);
    w = int64(bbox.w);
    h = int64(bbox.h);
                
    xmax = xmin+w;
    ymax = ymin+h;
                
    %fprintf('Before seq = %d : (%d,%d,%d,%d)\n',seq_id,xmin,ymin,xmax,ymax);
                
    xmin = max(xmin,1);
    ymin = max(ymin,1);
    xmax = min(xmax,width);
    ymax = min(ymax,height);                                                          
    
    
    color = [255,255,255];
    
    color_domain = [
        [255,255,255],
        [255,255,0],
        [255,0,255],
        [0,255,255],
        [0,0,255],
        [0,255,0],
        [255,0,0],
        [255,100,100],
        [100,255,100],
        [100,100,255],
        [0,150,255],
        [150,255,0]
        ];
    
    color = color_domain(class,:);
    
    
    I(ymin,xmin:xmax,1)=color(1);I(ymin,xmin:xmax,2)=color(2); I(ymin,xmin:xmax,3)=color(3);
    I(ymax,xmin:xmax,1)=color(1);I(ymax,xmin:xmax,2)=color(2); I(ymax,xmin:xmax,3)=color(3);
    I(ymin:ymax,xmin,1)=color(1);I(ymin:ymax,xmin,2)=color(2); I(ymin:ymax,xmin,3)=color(3);
    I(ymin:ymax,xmax,1)=color(1);I(ymin:ymax,xmax,2)=color(2); I(ymin:ymax,xmax,2)=color(2);
    y = I;
end