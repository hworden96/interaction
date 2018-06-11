% Program to automate cancer cell and platelet interaction experiment
% calculations (concentration, volume, dilutions)
clc; clear; nfig=0; 
%% Input Excel File
% Contains data on platelet concentration, volume, etc.
data=xlsread('interaction_input.xlsx','C4:C7');
%% Assign data
UnTrPlC=data(1,1);UnTrPlV=data(2,1); %untreated platelets conc (pl/uL) and vol (uL)
TrPlC=data(3,1); TrPlV=data(4,1); %treated platelets conc (pl/uL) and vol (uL)
%% Make dilution calculations
dil_fact=UnTrPlC/TrPlC; %dilution factor for untreated platelets
mult_fact=dil_fact-1; %multiplication factor for untreated platelets
%% Output Excel File
labels={'DilFact';'MultFact'};
values=[dil_fact;mult_fact];
T = table(labels,values)
filename = 'int_out.xlsx';
writetable(T,filename,'Sheet',1,'Range','A1')
%% adjust PC to same concentration as SPION PC and get volume for 150e6 total platelets
initial_platelet_concentration=input('Initial platelet concentration (pl/uL) = ')
SPION_platelet_concentration=input('Concentration of SPION-ated platelets (pl/uL) = ')

dilution_factor_1=initial_platelet_concentration/SPION_platelet_concentration
multiplication_factor=dilution_factor_1-1
volume_of_PC=150
volume_of_tyrode=volume_of_PC*multiplication_factor
total_volume=volume_of_PC+volume_of_tyrode
% mix calculated volumes of PC and Tyrode and remove 100uL for CD9-PE
% staining and 100uL for purified CD9 staining
%how many platelets in 50uL of adjusted PC and what is the dose of purified CD9
total_platelets_for_pur_CD9=50*SPION_platelet_concentration
volume_of_pur_CD9_for_PC=total_platelets_for_pur_CD9/1000000*6
% 3x excess of purified CD9 on these platelets

%% PC staining (SPION platelets get CD9-PE, normal platelets get both CD9-PE and purified CD9)


%% 1 million Hoechst MDAs in excess of purified CD9

cell_counter_concentration=input('Concentration of cancer cells according to cell counter (cells/mL) = ')
cell_counter_uL=cell_counter_concentration/1000
flow_concentration=input('Concentration of cancer cells according to flow cytometer (abs count within cancer cell gate) (cells/uL) = ')
average_conc=(cell_counter_uL+flow_concentration)/2
volume_to_million=1000000/average_conc
volume_purified_CD9=volume_to_million/8

%% 
