function Im_out = imageSubSample(Im_in, factor)

[h, w] = size(Im_in);
new_h = floor(h/factor)
new_w = floor(w/factor)
Im_out = zeros(new_h, new_w, class(Im_in));

for i=1:new_h
    for j=1:new_w
        Im_out(i,j) = Im_in((i-1)*factor+1,(j-1)*factor+1);
    end
end
end