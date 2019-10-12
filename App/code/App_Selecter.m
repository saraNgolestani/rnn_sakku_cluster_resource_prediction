
Data(:,:) = app_5_12(:,:);

j=1
for i = 1:945
    if Data(i,1) == 173
        app_173_data(j,:) = Data(i,:);
        j=j+1;
    end
end