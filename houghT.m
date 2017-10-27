function houghT(imagem, original)

[H,T,R] = hough(imagem);

P = houghpeaks(H,9,'threshold',ceil(0.2*max(H(:))));

lines = houghlines(imagem,T,R,P,'FillGap',170,'MinLength',100);

figure, imshow(original), hold on

    for k = 1:length(lines)
        xy = [lines(k).point1; lines(k).point2];
        
        x1 = xy(1,1);
        y1 = xy(1,2);
        x2 = xy(2,1);
        y2 = xy(2,2);
        slope = (y2-y1)/(x2-x1);
        xLeft = 1; 
        yLeft = slope * (xLeft - x1) + y1;
        xRight = 1000;
        yRight = slope * (xRight - x1) + y1;
        plot([xLeft, xRight], [yLeft, yRight], 'LineWidth',1,'Color','red');
    end
    
    contador = 0;
    
    for k = 1:(length(lines))
        for l = 2:(length(lines))
            r1 = lines(k).rho;
            r2 = lines(l).rho;
            theta1 = lines(k).theta;
            theta2 = lines(l).theta;
            
            c1 = cos((theta1*pi)/180);
            c2 = cos((theta2*pi)/180);
            
            s1 = sin((theta1*pi)/180);
            s2 = sin((theta2*pi)/180);

            % equacoes
            y = (r1 - (r1 * c1/(c1 + c2)) - (r2 * c1/(c1 + c2)))/((-s1 * c1/(c1 + c2)) - (s2 * c1/(c1 + c2)) + s1);
            x = ((r1 + r2 - (y * s1) - (y * s2)) / (c1 + c2));
                  
           
            plot([x,x],[y,y],'x','LineWidth',4,'Color','yellow');
        end
    end    
end

