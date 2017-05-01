%% Canny Edge Detector
function e = canny(image, sigma)
    Fx = gD(image, sigma, 1, 0);
    Fy = gD(image, sigma, 0, 1);
    Fxx = gD(image, sigma, 2, 0);
    Fxy = gD(image, sigma, 1, 1);
    Fyy = gD(image, sigma, 0, 2);
    Fw = sqrt(Fx .^2 + Fy .^2);
    cannys = zeros(size(image));
    Fww = ((Fx.^2 .* Fxx + Fy.^2 .* Fyy + 2 .* Fxy .* Fx .* Fy) ./ (Fx .^2 + Fy.^2));
    Fw2Fww = Fw .^2 .* Fww;
    Fww = Fw2Fww;
    for i = 2:length(image(:,1))-1
        for j = 2:length(image(1,:))-1
            % check if there is a sign change in Fww and  Fw is
            % signifanctly larger then 0
            if ((Fww(i-1,j) < 0) && (Fww(i+1,j) > 0) && Fw(i,j) > 0.08) ||...
               ((Fww(i-1,j) > 0 && Fww(i+1,j) < 0)&& Fw(i,j) > 0.08) || ...
               ((Fww(i,j-1) > 0 && Fww(i,j+1) < 0)&& Fw(i,j) > 0.08) || ...
               ((Fww(i,j-1) < 0 && Fww(i,j+1) > 0)&& Fw(i,j) > 0.08) || ...
               ((Fww(i-1,j-1) < 0 && Fww(i+1,j+1) > 0)&& Fw(i,j) > 0.08) || ...
               ((Fww(i-1,j-1) > 0 && Fww(i+1,j+1) < 0)&& Fw(i,j) > 0.08) || ...
               ((Fww(i+1,j-1) > 0 && Fww(i-1,j+1) < 0)&& Fw(i,j) > 0.08) || ...
               ((Fww(i+1,j-1) < 0 && Fww(i-1,j+1) > 0)&& Fw(i,j) > 0.08)
                   cannys(i,j) = Fw(i, j);
            end    
        end
    end    
    e = cannys;
end