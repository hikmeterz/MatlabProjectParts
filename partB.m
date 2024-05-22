function [coef1, coef2] = partB(x, y, d, epoch)
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
    
    % Plot
    % NO Need to Change This Part
    figure;
    scatter(x, y, 'filled', 'b');
    hold on;
    plot(x, o1, 'Linewidth', 1.5, 'Color', 'r');
    plot(x, o2, 'Linewidth', 1.5, 'Color', 'g');
    title('Part B');
end