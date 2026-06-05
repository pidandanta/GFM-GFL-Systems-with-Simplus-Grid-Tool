% =========================================================
% IEEE 39-Bus GFM Penetration Root Locus Plot (Auto-Scaling)
% =========================================================
clc; clear; close all;

output_dir = 'D:\82261\Simplus-Grid-Tool-master\modified_39bus_shan'; 
cd(output_dir);

files = {'20pct', '40pct', '60pct', '80pct', '100pct'};
colors = [
    0.60, 0.80, 1.00;
    0.40, 0.60, 0.90;
    0.20, 0.40, 0.80;
    0.10, 0.20, 0.70;
    0.00, 0.00, 0.50
];
markers = {'x', 'o', '^', 's', 'd'};

figure('Position', [150, 150, 850, 650], 'Color', 'w');
hold on; grid on; box on;

h_plots = zeros(1, length(files));

% 用于自适应坐标轴的极值记录
max_im = 0; 
min_re = 0;
max_re = 0;

fprintf('Drawing Auto-Scaled Root Locus...\n');

for i = 1:length(files)
    mat_filename = sprintf('Poles_IEEE_39Bus_GFM_%s.mat', files{i});
    load(mat_filename, 'poles');
    
    real_part = real(poles);
    imag_part = imag(poles);
    
    valid_re = [];
    valid_im = [];
    
    % 过滤条件：排除超高频和不相关的深层极点
    for k = 1:length(poles)
        if real_part(k) > -50 && real_part(k) < 5 && abs(imag_part(k)) < 250
            valid_re = [valid_re; real_part(k)];
            valid_im = [valid_im; imag_part(k)];
        end
    end
    
    % 更新坐标轴边界
    if ~isempty(valid_re)
        max_im = max(max_im, max(abs(valid_im)));
        min_re = min(min_re, min(valid_re));
        max_re = max(max_re, max(valid_re));
    end
    
    % 绘制散点
    h_plots(i) = scatter(valid_re, valid_im, 60, markers{i}, ...
        'MarkerEdgeColor', colors(i,:), ...
        'LineWidth', 1.5, ...
        'DisplayName', sprintf('%s GFM', files{i}(1:end-3)));
end

% 画虚轴
xline(0, 'k--', 'LineWidth', 1.5, 'HandleVisibility', 'off'); 

% --- 自适应坐标轴设置 ---
% X轴留出 10% 边距，确保包含 0 刻度
xlim([min_re - abs(min_re)*0.1, max(max_re + 2, 5)]); 
% Y轴上下对称，留出 10% 边距
y_limit = max_im * 1.1;
if y_limit < 10; y_limit = 50; end % 防止全实数极点时Y轴太窄
ylim([-y_limit, y_limit]); 

xlabel('Real Part (Neper/s)', 'FontSize', 12, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
ylabel('Imaginary Part (rad/s)', 'FontSize', 12, 'FontWeight', 'bold', 'FontName', 'Times New Roman');
title('Root Locus of IEEE 39-Bus System under Varying GFM Penetration', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');

legend(h_plots(h_plots~=0), 'Location', 'best', 'FontSize', 11, 'FontName', 'Times New Roman');
set(gca, 'FontSize', 11, 'LineWidth', 1.2, 'FontName', 'Times New Roman');

fprintf('Done. Y-axis automatically scaled to +/- %.1f\n', y_limit);