% Copyright 2020
%
%    Licensed under the Apache License, Version 2.0 (the "License");
%    you may not use this file except in compliance with the License.
%    You may obtain a copy of the License at
%
%        http://www.apache.org/licenses/LICENSE-2.0
%
%    Unless required by applicable law or agreed to in writing, software
%    distributed under the License is distributed on an "AS IS" BASIS,
%    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%    See the License for the specific language governing permissions and
%    limitations under the License.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [TccOut,resFolderOut] = MMM_eval_shortCircuit(motorModel,saveFlag,vector)

%expFlag = 0; % To evaluate the same speed points with measured temperatures of experimental data
if nargin()==1
    saveFlag = [];
    vector = [];
    expFlag = 0;
elseif nargin()==2
    expFlag = 0;
    vector = [];
else
    expFlag = 1;
end


Id      = motorModel.FluxMap_dq.Id;
Iq      = motorModel.FluxMap_dq.Iq;
Fd      = motorModel.FluxMap_dq.Fd;
Fq      = motorModel.FluxMap_dq.Fq;
T       = motorModel.FluxMap_dq.T;
Rs0     = motorModel.data.Rs;
p       = motorModel.data.p;
temp    = motorModel.data.tempCu;
% nMax    = motorModel.data.nmax;
nMax    = motorModel.WaveformSetup.EvalSpeed;
nPoints = 501;

if expFlag
    tempVect = vector.temp;
    nVect = vector.n;
else
    nVect = linspace(0,nMax,nPoints);
end

if strcmp(motorModel.data.axisType,'SR')
    if min(Id,[],'all')>=0
        Id = [-fliplr(Id(:,2:end)) Id];
        Iq = [Iq(:,2:end) Iq];
        Fd = [-fliplr(Fd(:,2:end)) Fd];
        Fq = [fliplr(Fq(:,2:end)) Fq];
        T  = [-fliplr(T(:,2:end)) T];
    end
else
    if min(Iq,[],'all')>=0
        Id = [Id(2:end,:);Id];
        Iq = [-flipud(Iq(2:end,:));Iq];
        Fd = [flipud(Fd(2:end,:));Fd];
        Fq = [-flipud(Fq(2:end,:));Fq];
        T  = [-flipud(T(2:end,:));T];
    end
end


idVect = Id(1,:);
iqVect = Iq(:,1);


Idq = Id+j*Iq;
Fdq = Fd+j*Fq;

w = nVect*pi/30*p;

Icc = zeros(size(nVect));
Tcc = zeros(size(nVect));
Vcc = zeros(size(nVect));

for ii=1:length(nVect)
    freq = nVect(ii)/60*p;
    if isempty(motorModel.acLossFactor)
        kAC = 1;
    else
        if expFlag
            kAC = calcSkinEffect(motorModel.acLossFactor,freq,tempVect(ii),'LUT');
        else
            kAC = calcSkinEffect(motorModel.acLossFactor,freq,temp,'LUT');
        end

    end
    if expFlag
        Rs = Rs0*kAC*(1+0.004*(-temp+tempVect(ii)));
    else
        Rs = Rs0*kAC;
    end


    Vdq = Rs*Idq+j*w(ii)*Fdq;
    c = contourc(idVect,iqVect,real(Vdq),[0 0]);
    idTmp = c(1,2:end);
    iqTmp = c(2,2:end);
    iiTmp = 1:1:numel(idTmp);
    VqTmp = interp2(Id,Iq,imag(Vdq),idTmp,iqTmp);
    index = interp1(VqTmp,iiTmp,0);
    idOK = interp1(iiTmp,idTmp,index);
    iqOK = interp1(iiTmp,iqTmp,index);
    Icc(ii) = idOK+j*iqOK;
    Tcc(ii) = interp2(Id,Iq,T,idOK,iqOK);
end

TccOut.n   = nVect;
TccOut.Tcc = Tcc;
TccOut.Icc = Icc;
TccOut.Vcc = Vcc;


%% outputs
pathname = motorModel.data.pathname;
motName  = motorModel.data.motorName;
resFolder = [motName '_results\MMM results\' 'ShortCircuit - ' int2str(motorModel.data.tempPM) 'degPM - ' int2str(temp) 'degCu' '\'];

resFolderOut = [pathname resFolder];

% create figures
for ii=1:4
    hfig(ii) = figure();
    figSetting();
    hax(ii) = axes('OuterPosition',[0 0 1 1]);
    switch ii
        case 1
            xlabel('$n$ [rpm]')
            ylabel('$T_{sc}$ [Nm]')
            set(gca,'XLim',[0 nMax])
            set(gcf,'FileName',[pathname resFolder 'torqueVSspeed.fig'])
        case 2
            xlabel('$n$ [rpm]')
            ylabel('$I_{sc}$ [A]')
            set(gca,'XLim',[0 nMax]);
            set(gcf,'FileName',[pathname resFolder 'currentVSspeed.fig'])
            legend('show','Location','northeast');
        case 3
            xlabel('$i_d$ [A]')
            ylabel('$i_q$ [A]')
            set(gca,...
                'XLim',[min(Id,[],'all') max(Id,[],'all')],...
                'YLim',[min(Iq,[],'all') max(Iq,[],'all')],...
                'DataAspectRatio',[1 1 1],...
                'CLim',[min(T,[],'all') max(T,[],'all')]);
            set(gcf,'FileName',[pathname resFolder 'DQcurrents.fig']);
            legend('show','Location','northeast');
        case 4
            view(gca,3)
            xlabel('$n$ [rpm]')
            ylabel('$i_d$ [A]')
            zlabel('$i_q$ [A]')
            set(gca,...
                'XLim',[0 nMax],...
                'YLim',max(abs(Id),[],'all')*[-1 1],...
                'ZLim',max(abs(Iq),[],'all')*[-1 1],...
                'DataAspectRatio',[nMax 2*max(abs(Id),[],'all') 2*max(abs(Iq),[],'all')]);
            set(gcf,'FileName',[pathname resFolder 'idVSiqVSn.fig']);
    end
end

plot(hax(1),nVect,Tcc,'-bo');

plot(hax(2),nVect,real(Icc),'-b','DisplayName','$i_d$')
plot(hax(2),nVect,imag(Icc),'-r','DisplayName','$i_q$')
plot(hax(2),nVect,abs(Icc),'--g','DisplayName','$I_{sc}$')

contourf(hax(3),Id,Iq,T,'DisplayName','$T$ [Nm]','ShowText','on');
contour(hax(3),Id,Iq,abs(Id+j*Iq),'-r','DisplayName','$I$ [A]');
plot(hax(3),real(Icc),imag(Icc),'-r','DisplayName','$I_{sc}$ [A]')

plot3(hax(4),nVect,real(Icc),imag(Icc),'-bo');


for ii=1:length(hfig)
    tmp = get(hfig(ii),'FileName');
    [~,name,~] = fileparts(tmp);
    set(hfig(ii),'Name',name);
end

%% Save figures
if isempty(saveFlag)
    answer = 'No';
    answer = questdlg('Save figures?','Save','Yes','No',answer);
else
    if saveFlag
        answer = 'Yes';
    else
        answer = 'No';
    end
end
if strcmp(answer,'Yes')
    if ~exist([pathname resFolder],'dir')
        mkdir([pathname resFolder]);
    end

    save([pathname resFolder 'ShortCircuitResults.mat'],'TccOut')

    for ii=1:length(hfig)
        savePrintFigure(hfig(ii));
    end
end

