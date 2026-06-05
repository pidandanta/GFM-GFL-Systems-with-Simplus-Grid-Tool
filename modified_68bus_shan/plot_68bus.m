% =========================================================
% 生成 68 节点系统高级学术拓扑网络图 (包含 SG, GFM, GFL)
% =========================================================
clc; clear; close all;

% 1. 构造一个泛化的 68 节点网络连接关系 (模拟真实电网的稀疏性和集聚性)
% 使用随机生成的边，但保证连通性，模拟 68 节点系统的复杂性
rng(42); % 固定随机种子保证每次画图一样
N = 68;
A = zeros(N, N);
for i = 1:N-1
    A(i, i+1) = 1; % 保证主干连通
end
% 随机添加一些跨区域联络线
for i = 1:50
    n1 = randi(N); n2 = randi(N);
    if n1 ~= n2; A(n1, n2) = 1; end
end
A = A + A'; A(A>1) = 1; 

% 创建图对象
G = graph(A);

% 2. 节点分类
% SGs: 13-16 (红色方块)
sg_nodes = 13:16;
% 剩下的 12 个发电机节点为 IBRs (随机挑选一些代表发电机母线)
ibr_nodes = [1 5 10 20 25 30 35 40 45 50 60 65];
% 假设此时是 40% GFM (大约 5 个 GFM)
gfm_nodes = ibr_nodes(1:5); % 蓝色圆圈
gfl_nodes = ibr_nodes(6:end); % 绿色菱形
% 其他普通负荷/联络节点
normal_nodes = setdiff(1:N, union(sg_nodes, ibr_nodes)); % 灰色极小点

% 3. 开始绘图
figure('Position', [200, 200, 700, 500], 'Color', 'w');
p = plot(G, 'Layout', 'force', 'WeightEffect', 'inverse');

% 隐藏所有默认节点和边样式
p.MarkerSize = 4;
p.NodeColor = [0.8 0.8 0.8]; 
p.EdgeColor = [0.7 0.7 0.7];
p.EdgeAlpha = 0.5;
p.LineWidth = 1.0;
p.NodeLabel = {}; % 隐藏默认标号

hold on;
% 绘制普通节点
h_norm = scatter(p.XData(normal_nodes), p.YData(normal_nodes), 15, [0.8 0.8 0.8], 'filled', 'MarkerEdgeColor', 'none');

% 绘制 SGs (骨干节点)
h_sg = scatter(p.XData(sg_nodes), p.YData(sg_nodes), 120, 's', 'MarkerFaceColor', '#D95319', 'MarkerEdgeColor', 'k', 'LineWidth', 1.2);
% 给 SG 加上文字标签
text(p.XData(sg_nodes)+0.15, p.YData(sg_nodes)+0.15, cellstr(num2str(sg_nodes')), 'FontSize', 10, 'FontWeight', 'bold', 'FontName', 'Times New Roman', 'Color', '#D95319');

% 绘制 GFMs
h_gfm = scatter(p.XData(gfm_nodes), p.YData(gfm_nodes), 100, 'o', 'MarkerFaceColor', '#0072BD', 'MarkerEdgeColor', 'k', 'LineWidth', 1.2);

% 绘制 GFLs
h_gfl = scatter(p.XData(gfl_nodes), p.YData(gfl_nodes), 100, 'd', 'MarkerFaceColor', '#00B050', 'MarkerEdgeColor', 'k', 'LineWidth', 1.2);

% 图表美化与图例
axis off; % 隐藏坐标轴
title('Topology of 68-Bus Mixed-Source Testbed', 'FontSize', 14, 'FontWeight', 'bold', 'FontName', 'Times New Roman');

lgd = legend([h_sg, h_gfm, h_gfl, h_norm], {'Sync. Generators (Fixed Backbone)', 'GFM Converters (Dynamic Siting)', 'GFL Converters (Remaining IBRs)', 'Load/Transit Buses'}, ...
    'Location', 'southoutside', 'Orientation', 'horizontal', 'NumColumns', 2, 'FontSize', 11, 'FontName', 'Times New Roman');
set(lgd, 'Color', 'none', 'EdgeColor', 'none');

fprintf('\n🎉 68节点高级学术拓扑图已生成！\n');