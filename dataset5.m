clc;
clear ;
close all;
% 
cd("C:\Users\Dell\OneDrive\Desktop\himi\btp\dataverse_files\act_channel_data\");
addpath("C:\Users\Dell\OneDrive\Desktop\himi\btp\codes\");
addpath("C:\Users\Dell\OneDrive\Desktop\himi\btp\codes\Features\");

filelist=dir('*.mat');
L=length(filelist);

%Parameters
overlap=250;
window_size=1000;
Willison_Amplitude_Threshold=0.005;

%Feature Vector along with Labels.
feat_seg=[];
features=[];
sub_data=[];
data=[];

for file_no=1:L
    load(filelist(file_no).name);
    for act=1:6
        
        if act==1
            a=Act_01_ch_1'; b=Act_01_ch_2'; c=Act_01_ch_3'; d=Act_01_ch_4'; e=Act_01_ch_5';  end
        if act==2
            a=Act_02_ch_1'; b=Act_02_ch_2'; c=Act_02_ch_3'; d=Act_02_ch_4'; e=Act_02_ch_5';   end
        if act==3
            a=Act_03_ch_1'; b=Act_03_ch_2'; c=Act_03_ch_3'; d=Act_03_ch_4'; e=Act_03_ch_5';  end
        if act==4
            a=Act_04_ch_1'; b=Act_04_ch_2'; c=Act_04_ch_3'; d=Act_04_ch_4'; e=Act_04_ch_5';  end
        if act==5
            a=Act_05_ch_1'; b=Act_05_ch_2'; c=Act_05_ch_3'; d=Act_05_ch_4'; e=Act_05_ch_5';  end
        if act==6
            a=Act_06_ch_1'; b=Act_06_ch_2'; c=Act_06_ch_3'; d=Act_06_ch_4'; e=Act_06_ch_5';  end
        
        for trial=1:6
            count=1;
            feat_seg=[];
            for seg_count=1:15
                
                x_1(seg_count,:)=a(trial,count:count+window_size-1);
                x_2(seg_count,:)=b(trial,count:count+window_size-1);
                x_3(seg_count,:)=c(trial,count:count+window_size-1);
                x_4(seg_count,:)=d(trial,count:count+window_size-1);
                x_5(seg_count,:)=e(trial,count:count+window_size-1);
              
                
                
                count=count+window_size-overlap;

     
                features_1=[Feature_Extraction(x_1(seg_count,:))];
                features_2=[Feature_Extraction(x_2(seg_count,:))];
                features_3=[Feature_Extraction(x_3(seg_count,:))];
                features_4=[Feature_Extraction(x_4(seg_count,:))];
                features_5=[Feature_Extraction(x_5(seg_count,:))];
               
            

                feat_seg=[feat_seg features_1 features_2 features_3 features_4 features_5];
            end

            features=[features; [feat_seg act]] ;
            
        end
        sub_data=[sub_data; features];
        features=[];
        
    end
    data=[data;sub_data];
    sub_data=[];
end
%Converting the Complex dataset values into doubles.
data=abs(data);
x=1:size(data,2);
% save('C:\Users\kaite\MATLAB Drive\Published\BTP\CODES\Modified\Data\Segmentation\','data');
csvwrite('C:\Users\Dell\OneDrive\Desktop\himi\btp\dataverse_files\segmentation\dataset5.csv', [x;data]);




% save('C:\Users\rohit\MATLAB Drive\BTP-RK\CODES\Modified\Data\dataset.mat','data');
% csvwrite('C:\Users\rohit\MATLAB Drive\BTP-RK\CODES\Modified\Data\dataset.csv', [x;data]);




