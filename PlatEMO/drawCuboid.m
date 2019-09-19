function drawCuboid(poi, ref)
    a= [ref;
        poi(1) ref(2) ref(3);
        poi(1) poi(2) ref(3);
        ref(1) poi(2) ref(3);
        ref(1) ref(2) poi(3);
        poi(1) ref(2) poi(3);
        poi(1) poi(2) poi(3);
        ref(1) poi(2) poi(3)];

    b= [1 2 6 5;
        2 3 7 6;
        3 4 8 7;
        4 1 5 8;
        1 2 3 4;
        5 6 7 8];
    p = patch('faces',b,...
    'vertices',a,...
    'facecolor',[.5 .5 .5],...
    'edgecolor',[1,1,1],...
    'facealpha',1);
    view(3)
    axis square
end
