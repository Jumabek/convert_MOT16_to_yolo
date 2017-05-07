function y = cell2annotation(cell_array)
    y = [];
    bbox = [];
    [frm_id,seq_id,xmin,ymin,w,h,confidence,class,visibility] = cell_array{:};
    
    bbox.('xmin') = xmin;
    bbox.('ymin') = ymin;
    bbox.('w') = w;
    bbox.('h') = h;
    
    y.('seq_id') = seq_id;
    y.('frm_id') = frm_id;
    y.('bbox') = bbox;
    y.('confidence') = confidence;
    y.('class') = class;
    y.('visibility') = visibility;
    
    return;
end


