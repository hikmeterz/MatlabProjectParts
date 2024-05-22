function [coef1, coef2,MSE1,MSE2] = partD(x, y, d, epoch)
    [m,~] = size(x);
    
    A = ones(m,d+1);
    for j=d:-1:1
        A(:,j) = A(:,j+1).*x;
    end
    
    MSE_best = 1000*1000*1000;
    coef1 = 0;
    coef2 = 0;
    for k=1:epoch
        B = [A A];
        for i=1:m
            if rand < 0.5
                B(i,1:d+1) = 0;
            else
                B(i,d+2:end) = 0;
            end
        end
        coef = (B'*B) \ (B'*y);

        o1 = A * coef(1:d+1);
        o2 = A * coef(d+2:end);
        e1 = abs(y - o1);
        e2 = abs(y - o2);
        e = min(e1, e2);
        MSE = e'*e / m;
        if MSE < MSE_best
            MSE_best = MSE;
            coef1 = coef(1:d+1);
            coef2 = coef(d+2:end);
        end
    end

    o1 = A * coef1;
    o2 = A * coef2;
    
    y1=ones(m,1);
    y2=ones(m,1);
    
    for i=1:m
       sonuc1=abs(y(i)-o1(i));
       sonuc2=abs(y(i)-o2(i));
       if(sonuc1<sonuc2)
           y1(i)=y(i);
       else
           y2(i)=y(i);
        end
        
    end    
    
    e3=abs(y1 - o1);
    e4=abs(y2 - o2);
    
    MSE1=e3'*e3 / m;
    MSE2=e4'*e4 / m;
    
    % Plot
    % NO Need to Change This Part
    figure;
    scatter(x, y, 'filled', 'b');
    hold on;
    plot(x, o1, 'Linewidth', 1.5, 'Color', 'r');
    plot(x, o2, 'Linewidth', 1.5, 'Color', 'g');
    title('Part D');
end