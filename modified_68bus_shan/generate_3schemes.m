% =========================================================
% 68节点系统：批量编译 3 种选址方案的 Simulink 模型 (修复双重路径)
% =========================================================
clc; clear; close all; warning('off','all');

% 保持在根目录
root_dir = 'D:\82261\Simplus-Grid-Tool-master';
cd(root_dir);

SchemeFiles = {'NETS_68Bus_Scheme1_Uniform', ...
               'NETS_68Bus_Scheme2_Hsys', ...
               'NETS_68Bus_Scheme3_gCSR'};

for i = 1:length(SchemeFiles)
    % 🎯 关键修复：直接使用裸文件名，让你的底层源码去拼接路径！
    UserDataName = SchemeFiles{i}; 
    
    fprintf('\n==========================================\n');
    fprintf('🚀 正在编译场景: %s (%d/3)\n', UserDataName, i);
    fprintf('==========================================\n');
    
    % 调用核心引擎
    UserDataType = 1; 
    SimplusGT.Toolbox.Main(); 
    
    % 精准保存模型到指定的子文件夹中
    NewModelName = ['Model_', UserDataName];
    NewModelPath = fullfile(root_dir, 'modified_68bus_shan', [NewModelName, '.slx']);
    
    if bdIsLoaded('mymodel_v1')
        save_system('mymodel_v1', NewModelPath);
        close_system(NewModelName);
        fprintf('✅ Simulink 模型已保存至: %s\n', NewModelPath);
    end
    
    % 精准保存底层数据
    clear GsysDss GsysSs YsysDss YsysSs ObjGsysDss ObjGsysSs; 
    DataFileName = fullfile(root_dir, 'modified_68bus_shan', ['Data_', UserDataName, '.mat']);
    save(DataFileName);
    fprintf('✅ 核心参数已保存至: %s\n', DataFileName);
    
    clearvars -except SchemeFiles i root_dir UserDataType;
end

fprintf('\n🎉 3 个模型编译圆满成功！马上进入加扰动和绝杀出图环节！\n');