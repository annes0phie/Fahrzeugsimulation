function Plot_4_8(plot_instance,gravity, lv, lh, lEG, lSG, is, m, theta)
deltaControlled = 0;
g = gravity;

EG = [max(-lEG, -lSG*0.9) 0 max(lEG, -lSG*0.9)];
SG = lSG;  % SG must be greater than min(EG)!
ChStern = 1./(g*SG); %20.5518;
% ChStern = 1 ./ (g * SG);
CvStern = convGradToCStern(EG, 0, g, ChStern);
vmax = int32(sqrt((lv+lh)/max(EG)) + 5); % charakteristische Geschwindigkeit
vmax = vmax + (5 - mod(vmax,5)); % Runden auf 5er Schritte
% vkrit = 20;
deltaH = 1;
deltaH_array = deltaH * ones(1,int32(vmax));
v = 1:vmax;
max_limit_y = 0;

colors = [[0 0 0.5], [0.8 0.4 0], [0.5 0 0]];
cut_axis = (0 == 1);
hold(plot_instance,'off');

for k = 1:size(CvStern,2)
    [~, ~, dpsi_val] = ESM_Run(10, 0.001, deltaH_array, 1, v, CvStern(k), ChStern, deltaControlled, lv, lh, is, m, theta, g);
    yVals = dpsi_val/(deltaH/is);
    max_limit_y = max(max(yVals), max_limit_y);
    if k > 1
        plot(plot_instance, v, yVals, 'LineWidth', 2, 'Color', colors((k-1)*3+1:k*3));
    else
        diffs = yVals(2:end) - yVals(1:end-1);
        falling = int32(diffs < 0);
        k_max = min(falling .* int32(1:(size(yVals,2)-1)) + (1-falling) .* 10000);
        plot(plot_instance, v(1:k_max), yVals(1:k_max), 'LineWidth', 2, 'Color', colors((k-1)*3+1:k*3));
    end
    hold('on');
end
ylim(plot_instance, [0 max_limit_y]);

grid(plot_instance, 'on');
legend(plot_instance, strcat('EG=',num2str(EG(1),2)),  strcat('EG=',num2str(EG(2),2)), strcat('EG=',num2str(EG(3),2)), 'Location','northwest');
end
