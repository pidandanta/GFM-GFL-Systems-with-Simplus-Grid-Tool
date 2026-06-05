%% 快速启动脚本
clear; clc;

% --- 用户设置区域 ---
% 修改这里来选择你想运行的场景 (20, 40, 50, 60, 80)
Pct = 80; 
% ------------------

SceneName = ['NETS_68Bus_GFM_', num2str(Pct), 'pct'];
DataFile = ['Data_', SceneName, '.mat'];
ModelFile = ['Model_', SceneName];

if exist(DataFile, 'file') && (exist([ModelFile, '.slx'], 'file') || exist(ModelFile, 'file'))
    % 1. 加载数据
    load(DataFile);
    fprintf('已加载 %d%% 渗透率场景的数据。\n', Pct);
    
    % 2. 打开模型
    open_system(ModelFile);
    fprintf('模型 %s 已打开。请点击运行按钮。\n', ModelFile);
    
    % 3. (可选) 自动开始仿真
    % set_param(ModelFile, 'SimulationCommand', 'start');
else
    error('找不到指定场景的数据或模型文件，请检查文件名。');
end