clear all; clc;

%% 1. 环境准备
% 获取当前路径并挂载工具箱（确保底层 S-Function 能找到路径）
root_path = fileparts(mfilename('fullpath'));
cd(root_path);
% 如果你的工具箱在其他位置，请修改此处
% addpath(genpath('D:\82261\Simplus-Grid-Tool-master')); 

%% 2. 加载之前保存的工作区变量
data_file = 'WSCC_9Bus_Workspace.mat';
if exist(data_file, 'file')
    load(data_file);
    fprintf('成功加载工作区变量。\n');
else
    error('未找到数据文件，请先运行一次 Main 脚本并保存数据。');
end

%% 3. 设置模型名称
% 这里的名称通常是 SimplusGT 默认生成的名称，例如 'mymodel_v1'
model_name = 'GFMGFL_9bus_v1'; 

%% 4. 打开模型并自动运行
if exist(model_name, 'file') == 4 || exist([model_name, '.slx'], 'file')
    open_system(model_name);
    fprintf('模型 %s 已打开。您可以直接点击 Run 运行仿真。\n', model_name);
else
    fprintf('警告：未找到模型文件 %s.slx，请确认文件在当前目录下。\n', model_name);
end