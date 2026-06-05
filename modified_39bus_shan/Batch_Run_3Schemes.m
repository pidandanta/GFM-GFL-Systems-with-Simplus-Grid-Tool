clc; clear; close all;
root_path = 'D:\82261\Simplus-Grid-Tool-master'; 
cd(root_path);
output_dir = fullfile(root_path, 'modified_39bus_shan'); 
addpath(genpath(output_dir));

ScenarioFiles = {'UserData_Scheme1_Uniform', 'UserData_Scheme2_Hsys', 'UserData_Scheme3_gCSR'};

for i = 1:length(ScenarioFiles)
    UserDataName = ScenarioFiles{i};
    UserDataType = 1; 
    SimplusGT.Toolbox.Main(); 
    
    NewModelName = ['Model_', UserDataName];
    if bdIsLoaded('mymodel_v1')
        save_system('mymodel_v1', fullfile(output_dir, [NewModelName, '.slx']));
        close_system('mymodel_v1', 0); 
    end
    
    clear GsysDss GsysSs YsysDss YsysSs ObjGsysDss ObjGsysSs; 
    save(fullfile(output_dir, ['Data_', UserDataName, '.mat']));
    clearvars -except ScenarioFiles i UserDataType root_path output_dir;
end
fprintf('\n🎉 3个完美对照模型已生成！\n');