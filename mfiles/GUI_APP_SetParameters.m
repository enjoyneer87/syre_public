% Copyright 2019
%
%    Licensed under the Apache License, Version 2.0 (the "License");
%    you may not use this file except in compliance with the License.
%    You may obtain a copy of the License at
%
%        http://www.apache.org/licenses/LICENSE-2.0
%
%    Unless required by applicable law or agreed to in writing, dx
%    distributed under the License is distributed on an "AS IS" BASIS,
%    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%    See the License for the specific language governing permissions and
%    limitations under the License.

function GUI_APP_SetParameters(app)

dataSet = app.dataSet;

set(app.currentMotFileName,'Value',dataSet.currentfilename);

% Main data panel
set(app.PolePairsEdit,'Value',num2str(dataSet.NumOfPolePairs));
set(app.NumOfSlotsEdit,'Value',num2str(dataSet.NumOfSlots));
set(app.NumberofstatorslotsEditField,'Value',int2str(dataSet.NumOfStatorSlots));
set(app.Numberof3phasesetsEditField,'Value',int2str(dataSet.Num3PhaseCircuit));
set(app.GapThiEdit,'Value',num2str(dataSet.AirGapThickness));
set(app.StatorOuterRadEdit,'Value',num2str(dataSet.StatorOuterRadius));
set(app.AirGapRadiusEdit,'Value',num2str(dataSet.AirGapRadius));
set(app.ShaftRadEdit,'Value',num2str(dataSet.ShaftRadius));
set(app.StackLenghtEdit,'Value',num2str(dataSet.StackLength));
set(app.TypeOfRotorList,'Value',dataSet.TypeOfRotor);

% Preliminary design
set(app.bRangeEdit,'Value',mat2str(dataSet.bRange));
set(app.xRangeEdit,'Value',mat2str(dataSet.xRange));

set(app.BfeEdit,'Value',num2str(dataSet.Bfe));
set(app.ktEdit,'Value',num2str(dataSet.kt));
set(app.RotoryokefactorpuEditField,'Value',num2str(dataSet.RotorYokeFactor));
set(app.StatoryokefactorpuEditField,'Value',num2str(dataSet.StatorYokeFactor));
set(app.FEAfixPopUp,'Value',int2str(dataSet.FEAfixN));
%set(app.CurrLoXBEdit,'Value',num2str(dataSet.CurrLoPP));
set(app.ThermalLoadingsyrmDesignEditField,'Value',num2str(dataSet.ThermalLoadKj));
set(app.CurrentDensityArmsmm2EditField,'Value',num2str(dataSet.CurrentDensity));
set(app.PMfillingfactorpuEditField,'Value',num2str(dataSet.kPM));

if strcmp(dataSet.TypeOfRotor,'IM')
    set(app.syrmDesignPushButt,'Enable','off')
    set(app.FEAfixPushButt,'Enable','off')
else
    set(app.syrmDesignPushButt,'Enable','on')
    set(app.FEAfixPushButt,'Enable','on')
end

f = dataSet.syrmDesignFlag;
switch f.hc
    case 0
        set(app.BarrierDesignDropDow,'Value','Constant flux barrier thickness');
    case 1
        set(app.BarrierDesignDropDow,'Value','Constant flux barrier permeance');
    case 2
        set(app.BarrierDesignDropDow,'Value','Lfq minimization');
end

switch f.dx
    case 0
        set(app.CarrierDesignDropDown,'Value','No flux carrier design');
    case 1
        set(app.CarrierDesignDropDown,'Value','Constant flux carrier thickness');
    case 2
        set(app.CarrierDesignDropDown,'Value','Flux carrier thickness proportional to d-flux');
end

switch f.i0
    case 0
        set(app.syrmDesignThermalInputDropDown,'Value','Constant thermal loading kj');
    case 1
        set(app.syrmDesignThermalInputDropDown,'Value','Constant current density J');
end

set(app.MTPApointButton,'Value',f.gf);
set(app.CharcurrentButton,'Value',f.ichf);
set(app.HWCSCcurrentButton,'Value',f.scf);
set(app.DemagratedButton,'Value',f.demag0);
set(app.DemagHWCButton,'Value',f.demagHWC);

%% Stator panel
set(app.ToothLengEdit,'Value',num2str(dataSet.ToothLength));
set(app.ToothWidthEdit,'Value',num2str(dataSet.ToothWidth));
set(app.SlotWidthEdit,'Value',num2str(dataSet.SlotWidth));
set(app.YokeLengthEditField,'Value',num2str(dataSet.YokeLength),'Enable','off');
if ~dataSet.ParallelSlotCheck
    set(app.SlotshapeDropDown,'Value','Trapezoidal');
else
    set(app.SlotshapeDropDown,'Value','Rectangular');
end
set(app.StatorSlotOpeEdit,'Value',num2str(dataSet.StatorSlotOpen));
set(app.ToothTanDepEdit,'Value',num2str(dataSet.ToothTangDepth));
set(app.ToothTangAngleEdit,'Value',num2str(dataSet.ToothTangAngle));
set(app.FillCorSlotEdit,'Value',num2str(dataSet.FilletCorner));

%% Rotor panel
if ~dataSet.ScaleCheck
    children = get(app.GridLayout21,'Children'); % ribs design panel and grid
    set(children,'Enable','on');
end
if strcmp(dataSet.TypeOfRotor,'SPM')
    set(app.NumberOfLayersEdit,'Enable','off','Value',num2str(dataSet.NumOfLayers));
    set(app.AlphapuEdit,'Enable','on','Editable','on','Value',mat2str(dataSet.ALPHApu));
    set(app.AlphadegreeEdit,'Enable','on','Editable','on','Value',mat2str(dataSet.ALPHAdeg));
    set(app.hcpuEdit,'Enable','on','Editable','on','Value',mat2str(dataSet.HCpu));
    set(app.hcmmEdit,'Enable','on','Editable','on','Value',num2str(dataSet.HCmm));
    set(app.DxEdit,'Enable','on','Value',num2str(dataSet.DepthOfBarrier));
    set(app.BetaEdit,'Enable','on','Value',mat2str(dataSet.betaPMshape));
    set(app.ThetaFBSEdit,'Enable','off');
    set(app.TanRibEdit,'Enable','off','Value',mat2str(dataSet.TanRibEdit));
    set(app.RadRibEdit,'Enable','off','Value',mat2str(dataSet.RadRibEdit));
    set(app.SplitRibsEditField,'Enable','off','Value','0');
    set(app.RadRibCheck,'Enable','off','Value',dataSet.RadRibCheck);
    set(app.RadialRibsAngleEditField,'Enable','off','Value',mat2str(dataSet.pontRangEdit));
    set(app.CentralBarriersShrinkEdit,'Enable','off','Value',mat2str(dataSet.CentralShrink));
    set(app.RotorFilletTan1EditField,'Enable','off','Value',mat2str(dataSet.RotorFilletTan1));
    set(app.RotorFilletTan2EditField,'Enable','off','Value',mat2str(dataSet.RotorFilletTan2));
    set(app.RotorFilletRadInEditField,'Enable','off','Value',mat2str(dataSet.RotorFilletIn));
    set(app.RotorFilletRadOutEditField,'Enable','off','Value',mat2str(dataSet.RotorFilletOut));
elseif strcmp(dataSet.TypeOfRotor,'Vtype')
    set(app.NumberOfLayersEdit,'Enable','on','Value',num2str(dataSet.NumOfLayers));
    set(app.AlphapuEdit,'Enable','on','Value',mat2str(dataSet.ALPHApu));
    set(app.AlphadegreeEdit,'Enable','on','Editable','off','Value',mat2str(dataSet.ALPHAdeg));
    set(app.hcpuEdit,'Enable','on','Value',mat2str(dataSet.HCpu));
    set(app.hcmmEdit,'Enable','on','Editable','off','Value',mat2str(dataSet.HCmm));
    set(app.DxEdit,'Enable','on','Value',mat2str(dataSet.DepthOfBarrier));
    set(app.BetaEdit,'Enable','on','Value',mat2str(dataSet.betaPMshape));
    set(app.CentralBarriersShrinkEdit,'Enable','off','Value',mat2str(dataSet.CentralShrink));
    set(app.NarrowFactorEdit,'Enable','off','Value',mat2str(dataSet.NarrowFactor));
    set(app.RadShiftInnerEdit,'Enable','off','Value',mat2str(dataSet.RadShiftInner));
    set(app.ThetaFBSEdit,'Enable','off');
    set(app.TanRibEdit,'Enable','on','Value',mat2str(dataSet.TanRibEdit));
    set(app.RadRibEdit,'Enable','on','Value',mat2str(dataSet.RadRibEdit));
    set(app.SplitRibsEditField,'Enable','off','Value','0');
    set(app.RadRibCheck,'Enable','on','Value',dataSet.RadRibCheck);
    if dataSet.RadRibCheck
        set(app.RadRibEdit,'Enable','on')
    else
        set(app.RadRibEdit,'Enable','off')
    end
    set(app.RotorFilletTan1EditField,'Enable','off','Value',mat2str(dataSet.RotorFilletTan1));
    set(app.RotorFilletTan2EditField,'Enable','off','Value',mat2str(dataSet.RotorFilletTan2));
    set(app.RadialRibsAngleEditField,'Enable','off','Value',mat2str(dataSet.pontRangEdit));
    set(app.RotorFilletRadInEditField,'Enable','on','Value',mat2str(dataSet.RotorFilletIn));
    set(app.RotorFilletRadOutEditField,'Enable','on','Value',mat2str(dataSet.RotorFilletOut));
elseif strcmp(dataSet.TypeOfRotor,'Spoke-type')
    set(app.NumberOfLayersEdit,'Enable','off','Value',num2str(dataSet.NumOfLayers));
    set(app.AlphapuEdit,'Enable','off','Value',mat2str(dataSet.ALPHApu));
    set(app.AlphadegreeEdit,'Enable','off','Editable','off','Value',mat2str(dataSet.ALPHAdeg));
    set(app.hcpuEdit,'Enable','off','Value',mat2str(dataSet.HCpu));
    set(app.hcmmEdit,'Enable','on','Editable','on','Value',mat2str(dataSet.HCmm));
    set(app.DxEdit,'Enable','off','Value',mat2str(dataSet.DepthOfBarrier));
    set(app.BetaEdit,'Enable','off','Value',mat2str(dataSet.betaPMshape));
    set(app.CentralBarriersShrinkEdit,'Enable','off','Value',mat2str(dataSet.CentralShrink));
    set(app.NarrowFactorEdit,'Enable','off','Value',mat2str(dataSet.NarrowFactor));
    set(app.RadShiftInnerEdit,'Enable','off','Editable','off','Value',mat2str(dataSet.RadShiftInner));
    set(app.ThetaFBSEdit,'Enable','off');
    set(app.TanRibEdit,'Enable','on','Value',mat2str(dataSet.TanRibEdit));
    set(app.RadRibEdit,'Enable','on','Value',mat2str(dataSet.RadRibEdit));
    set(app.SplitRibsEditField,'Enable','off','Value','0');
    set(app.RadRibCheck,'Enable','on','Value',dataSet.RadRibCheck);
else
    set(app.NumberOfLayersEdit,'Enable','on','Value',num2str(dataSet.NumOfLayers));
    set(app.AlphapuEdit,'Enable','on','Value',mat2str(dataSet.ALPHApu));
    set(app.AlphadegreeEdit,'Enable','on','Editable','off','Value',mat2str(dataSet.ALPHAdeg));
    set(app.hcpuEdit,'Enable','on','Value',mat2str(dataSet.HCpu));
    set(app.hcmmEdit,'Enable','on','Editable','on','Value',mat2str(dataSet.HCmm));
    if strcmp(dataSet.TypeOfRotor,'ISeg')
        set(app.DxEdit,'Enable','off','Value',mat2str(dataSet.DepthOfBarrier));
    else
        set(app.DxEdit,'Enable','on','Value',mat2str(dataSet.DepthOfBarrier));
    end
    set(app.BetaEdit,'Enable','off','Value',mat2str(dataSet.betaPMshape));
    if (strcmp(dataSet.TypeOfRotor,'Circular')||strcmp(dataSet.TypeOfRotor,'Seg'))
        set(app.ThetaFBSEdit,'Enable','on','Value',num2str(dataSet.thetaFBS))
    else
        set(app.ThetaFBSEdit,'Enable','off','Value',num2str(dataSet.thetaFBS))
    end
    set(app.TanRibEdit,'Enable','on','Value',mat2str(dataSet.TanRibEdit));
    set(app.RadRibEdit,'Enable','on','Value',mat2str(dataSet.RadRibEdit));

    if strcmp(dataSet.TypeOfRotor,'Seg')
        set(app.CentralBarriersShrinkEdit,'Enable','on','Value',mat2str(dataSet.CentralShrink));
        set(app.SplitRibsEditField,'Enable','on','Value',mat2str(dataSet.RadRibSplit));
        set(app.NarrowFactorEdit,'Enable','on','Value',mat2str(dataSet.NarrowFactor));
        set(app.RadShiftInnerEdit,'Enable','on','Value',mat2str(dataSet.RadShiftInner));
        set(app.RotorFilletTan1EditField,'Enable','on','Value',mat2str(dataSet.RotorFilletTan1));
        set(app.RotorFilletTan2EditField,'Enable','on','Value',mat2str(dataSet.RotorFilletTan2));
        set(app.RotorFilletRadInEditField,'Enable','on','Value',mat2str(dataSet.RotorFilletIn));
        set(app.RotorFilletRadOutEditField,'Enable','on','Value',mat2str(dataSet.RotorFilletOut));
    else
        set(app.SplitRibsEditField,'Enable','off','Value',mat2str(dataSet.RadRibSplit));
        set(app.CentralBarriersShrinkEdit,'Enable','off','Value',mat2str(dataSet.CentralShrink));
        set(app.NarrowFactorEdit,'Enable','off','Value',mat2str(dataSet.NarrowFactor));
        set(app.RadShiftInnerEdit,'Enable','off','Value',mat2str(dataSet.RadShiftInner));
        set(app.RotorFilletTan1EditField,'Enable','off','Value',mat2str(dataSet.RotorFilletTan1));
        set(app.RotorFilletTan2EditField,'Enable','off','Value',mat2str(dataSet.RotorFilletTan2));
        set(app.RotorFilletRadInEditField,'Enable','off','Value',mat2str(dataSet.RotorFilletIn));
        set(app.RotorFilletRadOutEditField,'Enable','off','Value',mat2str(dataSet.RotorFilletOut));
    end


    if any(dataSet.RadRibSplit)
        set(app.RadialRibsAngleEditField,'Enable','on','Value',mat2str(dataSet.pontRangEdit));
    else
        set(app.RadialRibsAngleEditField,'Enable','off','Value',mat2str(dataSet.pontRangEdit));
    end

    if (strcmp(dataSet.TypeOfRotor,'Circular') &&  dataSet.TanRibCheck)
        set(app.RotorFilletTan1EditField,'Enable','on','Value',mat2str(dataSet.RotorFilletTan1,3));
        set(app.RotorFilletTan2EditField,'Enable','on','Value',mat2str(dataSet.RotorFilletTan2,3));
    end

    set(app.RadRibCheck,'Enable','on','Value',dataSet.RadRibCheck);
    if dataSet.RadRibCheck
        set(app.RadRibEdit,'Enable','on')
        set(app.RotorFilletRadInEditField,'Enable','on')
        set(app.RotorFilletRadOutEditField,'Enable','on')
    else
        set(app.RadRibEdit,'Enable','off')
        set(app.RotorFilletRadInEditField,'Enable','off')
        set(app.RotorFilletRadOutEditField,'Enable','off')
    end
end

% Induction motor panel
if strcmp(dataSet.TypeOfRotor,'IM')
    set(app.NumberofrotorbarsEditField,'Enable','on','Value',num2str(dataSet.NumOfRotorBars));
    set(app.RotortoothlengthmmEditField,'Enable','on','Value',num2str(dataSet.RotorToothLength));
    set(app.RotortoothwidthmmEditField,'Enable','on','Value',num2str(dataSet.RotorToothWidth));
    set(app.RotorslotopenEditField,'Enable','on','Value',num2str(dataSet.RotorSlotOpen));
    set(app.RotortoothtangmmEditField,'Enable','on','Value',num2str(dataSet.RotorToothTangDepth));
    set(app.FilletatrotorslottopmmEditField,'Enable','on','Value',num2str(dataSet.RotorSlotFilletTop));
    set(app.FilletatrotorslotbottommmEditField,'Enable','on','Value',num2str(dataSet.RotorSlotFilletBottom));
else
    set(app.NumberofrotorbarsEditField,'Enable','off','Value',num2str(dataSet.NumOfRotorBars));
    set(app.RotortoothlengthmmEditField,'Enable','off','Value',num2str(dataSet.RotorToothLength));
    set(app.RotortoothwidthmmEditField,'Enable','off','Value',num2str(dataSet.RotorToothWidth));
    set(app.RotorslotopenEditField,'Enable','off','Value',num2str(dataSet.RotorSlotOpen));
    set(app.RotortoothtangmmEditField,'Enable','off','Value',num2str(dataSet.RotorToothTangDepth));
    set(app.FilletatrotorslottopmmEditField,'Enable','off','Value',num2str(dataSet.RotorSlotFilletTop));
    set(app.FilletatrotorslotbottommmEditField,'Enable','off','Value',num2str(dataSet.RotorSlotFilletBottom));
end

%% Options panel
set(app.ThermalLoadKj,'Value',num2str(dataSet.ThermalLoadKj));
set(app.CopperTempEdit,'Value',num2str(dataSet.TargetCopperTemp));
set(app.HousingTempEdit,'Value',num2str(dataSet.HousingTemp));
set(app.EstimatedCoppTemp,'Enable','on','Value',num2str(dataSet.EstimatedCopperTemp),'Editable','off');
set(app.CalculatedRatedCurrent,'Enable','on','Value',num2str(dataSet.RatedCurrent),'Editable','off');
set(app.JouleLossesEdit,'Value',num2str(dataSet.AdmiJouleLosses));
set(app.CurrentdensityEdit,'Value',num2str(dataSet.CurrentDensity));
set(app.Rsedit,'Enable','on','Value',num2str(dataSet.Rs),'Editable','off');
set(app.OverSpeedEdit,'Value',num2str(dataSet.OverSpeed));
set(app.MecTolerEdit,'Value',num2str(dataSet.MinMechTol));
set(app.RotorsleevethicknessmmEditField,'Value',num2str(dataSet.SleeveThickness));
set(app.RotorsleeveinterferencemmEditField,'Value',num2str(dataSet.SleeveInterference));
set(app.RotorsleevetemperatureCEditField,'Value',num2str(dataSet.SleeveTemperature));


%% Windings panel
set(app.SlotFillFacEdit,'Value',num2str(dataSet.SlotFillFactor));
if ~dataSet.SlotLayerPosCheck
    set(app.SlotlayerposDropDown,'Value','Stacked');
else
    set(app.SlotlayerposDropDown,'Value','Side-by-side');
end
set(app.TurnsSeriesEdit,'Value',num2str(dataSet.TurnsInSeries));
set(app.SlotSimulEdit,'Value',num2str(dataSet.Qs));
set(app.PitchWindEdit,'Value',num2str(dataSet.PitchShortFac));
set(app.Num3PhaseCircuitEdit,'Value',num2str(dataSet.Num3PhaseCircuit));
if dataSet.NumOfSlots<1
    set(app.PitchWindEdit,'Enable','off'); % concentrated winding
else
    set(app.PitchWindEdit,'Enable','on'); % distributed winding
end
set(app.SlotlinerthicknessmmEditField,'Value',num2str(dataSet.LinerThickness));


% Winding table
columnName = cell(1,floor(dataSet.Qs));
wCols      = cell(1,floor(dataSet.Qs));
for ii = 1 : floor(dataSet.Qs)
    columnName{ii} = ['Slot n� ',num2str(ii)];
    wCols{ii} = 50;
end
rowName{1} = 'Layer 1';
rowName{2} = 'Layer 2';
set(app.WinTable,'rowname',rowName,'columnname',columnName,'Data',dataSet.WinMatr(:,1:floor(dataSet.Qs)),'ColumnWidth',wCols);

% slot model
set(app.ConductorTypeEdit,'Value',dataSet.SlotConductorType);
set(app.ConductorInsulationEdit,'Value',num2str(dataSet.SlotConductorInsulation));
set(app.ParallelNumberEdit,'Enable','off','Value',num2str(dataSet.SlotConductorParallel));
%set(app.ConductorShapeEdit,'Value',num2str(dataSet.SlotConductorShape));
set(app.ConductorRadiusEdit,'Value',num2str(dataSet.SlotConductorRadius));
set(app.ConductorWidthEdit,'Value',num2str(dataSet.SlotConductorWidth));
set(app.ConductorHeightEdit,'Value',num2str(dataSet.SlotConductorHeight));
set(app.ConductorNumberEdit,'Value',num2str(dataSet.SlotConductorNumber));
set(app.ConductorSlotGapEdit,'Value',num2str(dataSet.SlotConductorBottomGap));
set(app.SlotModelFrequencyEdit,'Value',mat2str(dataSet.SlotConductorFrequency));
set(app.SlotModelTemperatureEdit,'Value',mat2str(round(dataSet.SlotConductorTemperature,1)));


%% Material panel
tmp = material_properties_conductor('0');
set(app.StatorslotmaterialDropDown,'Items',tmp.MatList);
set(app.RotorslotmaterialDropDown,'Items',tmp.MatList);
tmp = material_properties_layer('0');
set(app.FluxbarriermaterialDropDown,'Items',tmp.MatList);
tmp = material_properties_iron('0');
set(app.StatorcorematerialDropDown,'Items',tmp.MatList);
set(app.RotorcorematerialDropDown,'Items',tmp.MatList);
set(app.ShaftmaterialDropDown,'Items',['Air' tmp.MatList]);
tmp = material_properties_sleeve('0');
set(app.SleevematerialDropDown,'Items',tmp.MatList);

set(app.StatorslotmaterialDropDown,'Value',dataSet.SlotMaterial);
set(app.StatorcorematerialDropDown,'Value',dataSet.StatorMaterial);
set(app.RotorcorematerialDropDown,'Value',dataSet.RotorMaterial);
set(app.FluxbarriermaterialDropDown,'Value',dataSet.FluxBarrierMaterial);
set(app.ShaftmaterialDropDown,'Value',dataSet.ShaftMaterial);
set(app.RotorslotmaterialDropDown,'Value',dataSet.BarMaterial);
set(app.SleevematerialDropDown,'Value',dataSet.SleeveMaterial);

set(app.MassWindingEditField,'Enable','on','Editable','off','Value',num2str(dataSet.MassWinding));
set(app.MassStatorIronEditField,'Enable','on','Editable','off','Value',num2str(dataSet.MassStatorIron));
set(app.MassRotorIronEditField,'Enable','on','Editable','off','Value',num2str(dataSet.MassRotorIron));
set(app.MassFluxBarrierEditField,'Enable','on','Editable','off','Value',num2str(dataSet.MassMagnet));
set(app.MassTotalEditField,'Enable','on','Editable','off','Value',num2str(dataSet.MassWinding+dataSet.MassStatorIron+dataSet.MassRotorIron+dataSet.MassMagnet));
set(app.RotorInertiaEditField,'Enable','on','Editable','off','Value',num2str(dataSet.RotorInertia));
set(app.MassBarEditField,'Enable','on','Editable','off','Value',num2str(dataSet.MassRotorBar));

% PM design panel
nameCols = cell(1,size(dataSet.PMdim,2));
wCols    = cell(1,size(dataSet.PMdim,2));
for ii=1:length(nameCols)
    nameCols{ii} = ['Layer' int2str(ii)];
    wCols{ii} = 60;
end

nameRows{1} = 'Central width [mm]';
nameRows{2} = 'External width [mm]';
set(app.PMdimTable,'ColumnName',nameCols,'RowName',nameRows,'Data',round(dataSet.PMdim,4),'ColumnWidth',wCols);

nameCols = cell(1,size(dataSet.PMdim,2));
wCols    = cell(1,size(dataSet.PMdim,2));
for ii=1:length(nameCols)
    nameCols{ii} = ['Layer ' int2str(ii)];
    wCols{ii} = 60;
end
nameRows{1} = 'Central air gap [mm]';
nameRows{2} = 'External air gap [mm]';
set(app.PMclearanceTable,'ColumnName',nameCols,'RowName',nameRows,'Data',round(dataSet.PMclear,4),'ColumnWidth',wCols);

nameRows{1} = 'Central segments';
nameRows{2} = 'External segments';
set(app.PMNcSegmentsTable,'ColumnName',nameCols,'RowName',nameRows,'Data',round(dataSet.PMNc),'ColumnWidth',wCols);

set(app.PMNaSegments,'Value',num2str(dataSet.PMNa));
set(app.PMtemperatureEdit,'Value',num2str(dataSet.PMtemp));
set(app.CarCurEdit,'Value',num2str(dataSet.CurrPM,2));
set(app.BrPMEdit,'Value',num2str(dataSet.Br));
if strcmp(dataSet.FluxBarrierMaterial,'Air')
    set(app.PMdimTable,'Enable','off','ColumnEditable',false(1))
    set(app.PMclearanceTable,'Enable','off','ColumnEditable',false(1))
    set(app.PMNcSegmentsTable,'Enable','off','ColumnEditable',false(1))
    set(app.PMDesignPush,'Enable','off')
    set(app.PMtemperatureEdit,'Enable','off')
    set(app.BrPMEdit,'Enable','off')
    set(app.CarCurEdit,'Enable','off')
    set(app.PMNaSegments,'Enable','off')
else
    set(app.PMtemperatureEdit,'Enable','on')
    set(app.BrPMEdit,'Enable','on')
    if (strcmp(dataSet.TypeOfRotor,'SPM')||strcmp(dataSet.TypeOfRotor,'Fluid'))
        set(app.PMdimTable,'Enable','off','ColumnEditable',false(1))
        set(app.PMclearanceTable,'Enable','off','ColumnEditable',false(1))
        set(app.PMNcSegmentsTable,'Enable','off','ColumnEditable',false(1))
        set(app.PMNaSegments,'Enable','off')
        set(app.PMDesignPush,'Enable','off')
        set(app.CarCurEdit,'Enable','off')
    elseif strcmp(dataSet.TypeOfRotor,'Spoke-type')
        set(app.PMdimTable,'Enable','on','ColumnEditable',true(1))
        set(app.PMclearanceTable,'Enable','on','ColumnEditable',true(1))
        set(app.PMNcSegmentsTable,'Enable','on','ColumnEditable',true(1))
        set(app.PMNaSegments,'Enable','on')
        set(app.PMDesignPush,'Enable','on')
        set(app.CarCurEdit,'Enable','on')
    else
        set(app.PMdimTable,'Enable','on','ColumnEditable',true(1))
        set(app.PMclearanceTable,'Enable','on','ColumnEditable',true(1))
        set(app.PMNcSegmentsTable,'Enable','on','ColumnEditable',true(1))
        set(app.PMNaSegments,'Enable','on')
        set(app.PMDesignPush,'Enable','on')
        set(app.CarCurEdit,'Enable','on')
    end
end

if (strcmp(dataSet.TypeOfRotor,'Circular')||strcmp(dataSet.TypeOfRotor,'Vtype'))
    set(app.PMNcSegmentsTable,'Enable','off','ColumnEditable',false(1))
end

% Optimization panel
set(app.MaxGenEdit,'Value',num2str(dataSet.MaxGen));
set(app.XPopEdit,'Value',num2str(dataSet.XPop));
set(app.SimPosMOEdit,'Value',num2str(dataSet.SimPoMOOA));
set(app.RotorPosiMOEdit,'Value',num2str(dataSet.RotPoMOOA));
set(app.SimPosFinerEdit,'Value',num2str(dataSet.SimPoFine));
set(app.RotorPosFinerEdit,'Value',num2str(dataSet.RotPoFine));
% opt variables and bounds
if strcmp(dataSet.TypeOfRotor,'SPM')
    set(app.Dalpha1BouCheck,'Enable','off','Value',0);
    set(app.Alpha1BouEdit,'Enable','off');
    set(app.DalphaBouCheck,'Enable','off','Value',0);
    set(app.DeltaAlphaBouEdit,'Enable','off','Value',mat2str(dataSet.DeltaAlphaBou));
else
    set(app.Dalpha1BouCheck,'Enable','on','Value',dataSet.Dalpha1BouCheck);
    set(app.DalphaBouCheck,'Enable','on','Value',dataSet.DalphaBouCheck);
    if dataSet.Dalpha1BouCheck
        set(app.Alpha1BouEdit,'Enable','on');
    else
        set(app.Alpha1BouEdit,'Enable','off');
    end
    if dataSet.DalphaBouCheck
        set(app.DeltaAlphaBouEdit,'Enable','on');
    else
        set(app.DeltaAlphaBouEdit,'Enable','off');
    end
end

if strcmp(dataSet.TypeOfRotor,'Seg')

    set(app.CentralShrinkBouCheck,'Enable','on','Value',dataSet.CentralShrinkBouCheck);
    set(app.RadShiftInnerBouCheck,'Enable','on','Value',dataSet.RadShiftInnerBouCheck);

    if dataSet.CentralShrinkBouCheck
        set(app.CentralShrinkBouEdit,'Enable','on');
    else
        set(app.CentralShrinkBouEdit,'Enable','off');
    end

    if dataSet.RadShiftInnerBouCheck
        set(app.RadShiftInnerBouEdit,'Enable','on');
    else
        set(app.RadShiftInnerBouEdit,'Enable','off');
    end

else
    set(app.CentralShrinkBouCheck,'Enable','off','Value',dataSet.CentralShrinkBouCheck);
    set(app.RadShiftInnerBouCheck,'Enable','off','Value',dataSet.RadShiftInnerBouCheck);
    set(app.CentralShrinkBouEdit,'Enable','off');
    set(app.RadShiftInnerBouEdit,'Enable','off');

end

set(app.hcBouCheck,'Enable','on','Value',dataSet.hcBouCheck);
if dataSet.hcBouCheck
    set(app.hcBouEdit,'Enable','on');
else
    set(app.hcBouEdit,'Enable','off');
end

if (strcmp(dataSet.TypeOfRotor,'ISeg')||strcmp(dataSet.TypeOfRotor,'SPM'))
    set(app.DxBouCheck,'Enable','off','Value',0);
    set(app.DfeBouEdit,'Enable','off');
else
    set(app.DxBouCheck,'Enable','on','Value',dataSet.DxBouCheck);
    if dataSet.DxBouCheck
        set(app.DfeBouEdit,'Enable','on');
    else
        set(app.DfeBouEdit,'Enable','off');
    end
end

set(app.GapBouCheck,'Enable','on','Value',dataSet.GapBouCheck);
if dataSet.GapBouCheck
    set(app.GapBouEdit,'Enable','on');
else
    set(app.GapBouEdit,'Enable','off');
end

if strcmp(dataSet.FluxBarrierMaterial,'Air')
    set(app.BrBouCheck,'Enable','off','Value',0);
    set(app.BrBouEdit,'Enable','off');
else
    set(app.BrBouCheck,'Enable','on','Value',dataSet.BrBouCheck);
    if dataSet.BrBouCheck
        set(app.BrBouEdit,'Enable','on');
    else
        set(app.BrBouEdit,'Enable','off');
    end
end

set(app.AirgapRadiusBouCheck,'Enable','on','Value',dataSet.AirgapRadiusBouCheck);
if dataSet.AirgapRadiusBouCheck
    set(app.AirgapRadiusBouEdit,'Enable','on');
else
    set(app.AirgapRadiusBouEdit,'Enable','off');
end

set(app.ToothWidthBouCheck,'Enable','on','Value',dataSet.ToothWidthBouCheck);
if dataSet.ToothWidthBouCheck
    set(app.ToothWidthBouEdit,'Enable','on');
else
    set(app.ToothWidthBouEdit,'Enable','off');
end

set(app.ToothLengthBouCheck,'Enable','on','Value',dataSet.ToothLengthBouCheck);
if dataSet.ToothLengthBouCheck
    set(app.ToothLenBouEdit,'Enable','on');
else
    set(app.ToothLenBouEdit,'Enable','off');
end

set(app.StatorSlotOpenBouCheck,'Enable','on','Value',dataSet.StatorSlotOpenBouCheck);
if dataSet.StatorSlotOpenBouCheck
    set(app.StatorSlotOpenBouEdit,'Enable','on');
else
    set(app.StatorSlotOpenBouEdit,'Enable','off');
end

set(app.ToothTangDepthBouCheck,'Enable','on','Value',dataSet.ToothTangDepthBouCheck);
if dataSet.ToothTangDepthBouCheck
    set(app.ToothTangDepthBouEdit,'Enable','on');
else
    set(app.ToothTangDepthBouEdit,'Enable','off');
end

if (strcmp(dataSet.TypeOfRotor,'SPM')||strcmp(dataSet.TypeOfRotor,'Vtype'))
    set(app.BetaPMshapeBouCheck,'Enable','on','Value',dataSet.BetaPMshapeBouCheck);
    if dataSet.BetaPMshapeBouCheck
        set(app.BetaPMshapeBouEdit,'Enable','on');
    else
        set(app.BetaPMshapeBouEdit,'Enable','off');
    end
else
    set(app.BetaPMshapeBouCheck,'Enable','off','Value',0);
    set(app.BetaPMshapeBouEdit,'Enable','off');
end

if (strcmp(dataSet.TypeOfRotor,'Circular')||strcmp(dataSet.TypeOfRotor,'Seg'))
    set(app.ThetaFBSBouCheck,'Enable','on','Value',dataSet.ThetaFBSBouCheck);
    if dataSet.ThetaFBSBouCheck
        set(app.ThetaFBSBouEdit,'Enable','on');
    else
        set(app.ThetaFBSBouEdit,'Enable','off');
    end
else
    set(app.ThetaFBSBouCheck,'Enable','off','Value',0);
    set(app.ThetaFBSBouEdit,'Enable','off');
end

if (strcmp(dataSet.FluxBarrierMaterial,'Air')||strcmp(dataSet.TypeOfRotor,'Fluid')||strcmp(dataSet.TypeOfRotor,'SPM'))
    set(app.PMdimBouCheck,'Enable','off','Value',0);
    set(app.PMdimBouEdit,'Enable','off');
else
    set(app.PMdimBouCheck,'Enable','on','Value',dataSet.PMdimBouCheck);
    if dataSet.PMdimBouCheck
        set(app.PMdimBouEdit,'Enable','on');
    else
        set(app.PMdimBouEdit,'Enable','off');
    end
end

set(app.GammaBouCheck,'Enable','on','Value',dataSet.GammaBouCheck);
if dataSet.GammaBouCheck
    set(app.PhaseAngleCurrBouEdit,'Enable','on');
else
    set(app.PhaseAngleCurrBouEdit,'Enable','off');
end

if (strcmp(dataSet.TypeOfRotor,'Seg')||strcmp(dataSet.TypeOfRotor,'Circular'))

    set(app.RadRibBouCheck,'Enable','on','Value',dataSet.RadRibBouCheck);
    set(app.TanRibBouCheck,'Enable','on','Value',dataSet.TanRibBouCheck);

    set(app.FilletRadribsinBouCheck,'Enable','on','Value',dataSet.FilletRad1BouCheck);
    set(app.FilletRadribsoutBouCheck,'Enable','on','Value',dataSet.FilletRad2BouCheck);
    set(app.FilletTanribsinBouCheck,'Enable','on','Value',dataSet.FilletTan1BouCheck);
    set(app.FilletTanribsoutBouCheck,'Enable','on','Value',dataSet.FilletTan2BouCheck);

    if dataSet.RadRibBouCheck
        set(app.RadRibBouEdit,'Enable','on');
    else
        set(app.RadRibBouEdit,'Enable','off');
    end
    if dataSet.TanRibBouCheck
        set(app.TanRibBouEdit,'Enable','on');
    else
        set(app.TanRibBouEdit,'Enable','off');
    end

    if dataSet.FilletRad1BouCheck
        set(app.FilletRadribsinBou,'Enable','on')
    else
        set(app.FilletRadribsinBou,'Enable','off')
    end
    if dataSet.FilletRad2BouCheck
        set(app.FilletRadribsoutBou,'Enable','on')
    else
        set(app.FilletRadribsoutBou,'Enable','off')
    end
    if dataSet.FilletTan1BouCheck
        set(app.FilletTanribsinBou,'Enable','on')
    else
        set(app.FilletTanribsinBou,'Enable','off')
    end
    if dataSet.FilletTan2BouCheck
        set(app.FilletTanribsoutBou,'Enable','on')
    else
        set(app.FilletTanribsoutBou,'Enable','off')
    end
else

    set(app.RadRibBouCheck,'Enable','off','Value',0);
    set(app.TanRibBouCheck,'Enable','off','Value',0);
    set(app.FilletRadribsinBouCheck,'Enable','off','Value',0);
    set(app.FilletRadribsoutBouCheck,'Enable','off','Value',0);
    set(app.FilletTanribsinBouCheck,'Enable','off','Value',0);
    set(app.FilletTanribsoutBouCheck,'Enable','off','Value',0);

    set(app.RadRibBouEdit,'Enable','off');
    set(app.TanRibBouEdit,'Enable','off');
    set(app.FilletRadribsinBou,'Enable','off')
    set(app.FilletRadribsoutBou,'Enable','off')
    set(app.FilletTanribsinBou,'Enable','off')
    set(app.FilletTanribsoutBou,'Enable','off')
end


app.Alpha1BouEdit.Value          = mat2str(dataSet.Alpha1Bou);
app.DeltaAlphaBouEdit.Value      = mat2str(dataSet.DeltaAlphaBou);
app.hcBouEdit.Value              = mat2str(dataSet.hcBou);
app.DfeBouEdit.Value             = mat2str(dataSet.DfeBou);
app.GapBouEdit.Value             = mat2str(dataSet.GapBou);
app.BrBouEdit.Value              = mat2str(dataSet.BrBou);
app.AirgapRadiusBouEdit.Value    = mat2str(dataSet.GapRadiusBou);
app.ToothWidthBouEdit.Value      = mat2str(dataSet.ToothWiBou);
app.ToothLenBouEdit.Value        = mat2str(dataSet.ToothLeBou);
app.StatorSlotOpenBouEdit.Value  = mat2str(dataSet.StatorSlotOpenBou);
app.ToothTangDepthBouEdit.Value  = mat2str(dataSet.ToothTangDepthBou);
app.BetaPMshapeBouEdit.Value     = mat2str(dataSet.BetaPMshapeBou);
app.ThetaFBSBouEdit.Value        = mat2str(dataSet.ThetaFBSBou);
app.PMdimBouEdit.Value           = mat2str(dataSet.PMdimBou,2);
app.PhaseAngleCurrBouEdit.Value  = mat2str(dataSet.PhaseAngleCurrBou);
app.RadRibBouEdit.Value          = mat2str(dataSet.RadRibBou);
app.TanRibBouEdit.Value          = mat2str(dataSet.TanRibBou);
app.CentralShrinkBouEdit.Value   = mat2str(dataSet.CentralShrinkBou);
app.RadShiftInnerBouEdit.Value   = mat2str(dataSet.RadShiftInnerBou);
app.FilletRadribsinBou.Value     = mat2str(dataSet.FilletRad1Bou);
app.FilletRadribsoutBou.Value    = mat2str(dataSet.FilletRad2Bou);
app.FilletTanribsinBou.Value     = mat2str(dataSet.FilletTan1Bou);
app.FilletTanribsoutBou.Value    = mat2str(dataSet.FilletTan2Bou);

% opt objectives
set(app.TorqueOptCheck,'Value',dataSet.TorqueOptCheck);
if dataSet.TorqueOptCheck
    set(app.MinExpTorEdit,'Enable','on');
else
    set(app.MinExpTorEdit,'Enable','off');
end
set(app.TorRipOptCheck,'Value',dataSet.TorRipOptCheck);
if dataSet.TorRipOptCheck
    set(app.MaxExpeRippleTorEdit,'Enable','on');
else
    set(app.MaxExpeRippleTorEdit,'Enable','off');
end
set(app.MassCuOptCheck,'Value',dataSet.MassCuOptCheck);
if dataSet.MassCuOptCheck
    set(app.MassCuEdit,'Enable','on');
else
    set(app.MassCuEdit,'Enable','off');
end
set(app.MassPMOptCheck,'Value',dataSet.MassPMOptCheck);
if dataSet.MassPMOptCheck
    set(app.MassPMEdit,'Enable','on');
else
    set(app.MassPMEdit,'Enable','off');
end

set(app.PowerFactorOptCheck,'Value',dataSet.PowerFactorOptCheck);
if dataSet.PowerFactorOptCheck
    set(app.MinExpPowerFactorEdit,'Enable','on');
else
    set(app.MinExpPowerFactorEdit,'Enable','off');
end

set(app.NoLoadFluxOptCheck,'Value',dataSet.NoLoadFluxOptCheck);
if dataSet.NoLoadFluxOptCheck
    set(app.MaxExpNoLoadFluxEdit,'Enable','on');
else
    set(app.MaxExpNoLoadFluxEdit,'Enable','off');
end

set(app.MechStressOptCheck,'Value',dataSet.MechStressOptCheck);
set(app.flag_OptCurrConst,'Value',dataSet.flag_OptCurrConst);
% if dataSet.MechStressOptCheck
%     set(app.MaxExpMechStressEdit,'Enable','on');
% else
%     set(app.MaxExpMechStressEdit,'Enable','off');
% end


app.MinExpTorEdit.Value          = num2str(dataSet.MinExpTorque);
app.MaxExpeRippleTorEdit.Value   = num2str(dataSet.MaxRippleTorque);
app.MassCuEdit.Value             = num2str(dataSet.MaxCuMass);
app.MassPMEdit.Value             = num2str(dataSet.MaxPMMass);

app.MinExpPowerFactorEdit.Value  = num2str(dataSet.MinExpPowerFactor);
app.MaxExpNoLoadFluxEdit.Value   = num2str(dataSet.MaxExpNoLoadFlux);
%app.MaxExpMechStressEdit.Value   = num2str(dataSet.MaxExpMechStress);

set(app.CurrentOverLoadEdit,'Value',num2str(dataSet.CurrOverLoad));

if (dataSet.custom~=0 || strcmp(dataSet.TypeOfRotor,'IM'))
    set(app.OptimizePush,'Enable','off')
else
    set(app.OptimizePush,'Enable','on')
end

%% Post-processing panel
set(app.SpanEltPPEdit,'Value',num2str(dataSet.AngularSpanPP));
set(app.GammaPPEdit,'Value',mat2str(dataSet.GammaPP));
set(app.CurrLoPPEdit,'Value',mat2str(dataSet.CurrLoPP));
set(app.CurrentPP,'Value',mat2str(round(dataSet.CurrLoPP*dataSet.RatedCurrent,1)));
set(app.NumOfRotorPosiPPEdit,'Value',num2str(dataSet.NumOfRotPosPP));
set(app.BrPPEdit,'Value',mat2str(round(dataSet.BrPP,3)));
set(app.TempPPEdit,'Value',mat2str(dataSet.tempPP));
set(app.NGridPPEdit,'Value',num2str(dataSet.NumGrid));
set(app.EvaluatedSpeedEdit,'Value',mat2str(dataSet.EvalSpeed));
switch dataSet.MapQuadrants
    case 1
        set(app.MapQuadrantsPopUp,'Value','1 quadrant');
    case 2
        set(app.MapQuadrantsPopUp,'Value','2 quadrants');
    case 4
        set(app.MapQuadrantsPopUp,'Value','4 quadrants');
end
set(app.Active3phasesetsEditField,'Value',mat2str(dataSet.Active3PhaseSets));
%Custom Current
set(app.CustomCurrentFile,'Value',dataSet.CustomCurrentFilename);
set(app.AxistypeDropDown,'Value',dataSet.axisType);

switch dataSet.EvalType
    case 'singt'
        set(app.EvalTypePopUp,'Value','Single Point');
        set(app.SpanEltPPEdit,'Enable','on');
        set(app.GammaPPEdit,'Enable','on');
        set(app.CurrLoPPEdit,'Enable','on');
        set(app.CurrentPP,'Enable','on');
        set(app.NumOfRotorPosiPPEdit,'Enable','on');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','off');
        set(app.EvaluatedSpeedEdit,'Enable','on');
        set(app.StartPProMagnetPush,'Enable','on');
        set(app.StartPProAnsysPush,'Enable','on');
        set(app.MapQuadrantsPopUp,'Enable','off');
        set(app.Active3phasesetsEditField,'Enable','on');
        set(app.AxistypeDropDown,'Enable','on');
        set(app.JMAGButton,'Enable','on')
    case 'singm'
        set(app.EvalTypePopUp,'Value','Flux Map');
        set(app.SpanEltPPEdit,'Enable','on');
        set(app.GammaPPEdit,'Enable','off');
        set(app.CurrLoPPEdit,'Enable','on');
        set(app.CurrentPP,'Enable','on');
        set(app.NumOfRotorPosiPPEdit,'Enable','on');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','on');
        set(app.EvaluatedSpeedEdit,'Enable','on');
        set(app.StartPProMagnetPush,'Enable','on');
        set(app.StartPProAnsysPush,'Enable','off');
        set(app.MapQuadrantsPopUp,'Enable','on');
        set(app.Active3phasesetsEditField,'Enable','on');
        set(app.CustomCurrentSwitch,'Value','Off');     % no custom current
        set(app.AxistypeDropDown,'Enable','on');
        set(app.JMAGButton,'Enable','on')
    case 'demagArea'
        set(app.EvalTypePopUp,'Value','Demagnetization Analysis');
        set(app.SpanEltPPEdit,'Enable','off');
        set(app.GammaPPEdit,'Enable','on');
        set(app.CurrLoPPEdit,'Enable','on');
        set(app.CurrentPP,'Enable','on')
        set(app.NumOfRotorPosiPPEdit,'Enable','off');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','off');
        set(app.EvaluatedSpeedEdit,'Enable','off');
        set(app.StartPProMagnetPush,'Enable','off');
        set(app.StartPProAnsysPush,'Enable','off');
        set(app.MapQuadrantsPopUp,'Enable','off');
        set(app.Active3phasesetsEditField,'Enable','off');
        set(app.CustomCurrentSwitch,'Value','Off');     % no custom current
        set(app.AxistypeDropDown,'Enable','on');
        set(app.JMAGButton,'Enable','off')
    case 'idemag'
        set(app.EvalTypePopUp,'Value','Demagnetization Curve');
        set(app.SpanEltPPEdit,'Enable','off');
        set(app.GammaPPEdit,'Enable','off');
        set(app.CurrLoPPEdit,'Enable','off');
        set(app.CurrentPP,'Enable','off')
        set(app.NumOfRotorPosiPPEdit,'Enable','off');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','off');
        set(app.EvaluatedSpeedEdit,'Enable','off');
        set(app.StartPProMagnetPush,'Enable','off');
        set(app.StartPProAnsysPush,'Enable','off');
        set(app.MapQuadrantsPopUp,'Enable','off');
        set(app.Active3phasesetsEditField,'Enable','off');
        set(app.CustomCurrentSwitch,'Value','Off');    % no custom current
        set(app.AxistypeDropDown,'Enable','off');
        set(app.JMAGButton,'Enable','off')
    case 'ichval'
        set(app.EvalTypePopUp,'Value','Characteristic Current');
        set(app.SpanEltPPEdit,'Enable','on');
        set(app.GammaPPEdit,'Enable','off');
        set(app.CurrLoPPEdit,'Enable','off');
        set(app.CurrentPP,'Enable','off')
        set(app.NumOfRotorPosiPPEdit,'Enable','on');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','off');
        set(app.EvaluatedSpeedEdit,'Enable','off');
        set(app.StartPProMagnetPush,'Enable','off');
        set(app.StartPProAnsysPush,'Enable','off');
        set(app.MapQuadrantsPopUp,'Enable','off');
        set(app.Active3phasesetsEditField,'Enable','off');
        set(app.CustomCurrentSwitch,'Value','Off');     % no custom current
        set(app.AxistypeDropDown,'Enable','off');
        set(app.JMAGButton,'Enable','off')
    case 'flxdn'
        set(app.EvalTypePopUp,'Value','Flux Density Analysis');
        set(app.SpanEltPPEdit,'Enable','on');
        set(app.GammaPPEdit,'Enable','on');
        set(app.CurrLoPPEdit,'Enable','on');
        set(app.CurrentPP,'Enable','on');
        set(app.NumOfRotorPosiPPEdit,'Enable','on');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','off');
        set(app.EvaluatedSpeedEdit,'Enable','off');
        set(app.StartPProMagnetPush,'Enable','off');
        set(app.StartPProAnsysPush,'Enable','off');
        set(app.MapQuadrantsPopUp,'Enable','off');
        set(app.Active3phasesetsEditField,'Enable','on');
        set(app.CustomCurrentSwitch,'Value','Off');    % no custom current
        set(app.AxistypeDropDown,'Enable','on');
        set(app.JMAGButton,'Enable','off')
    case 'izero'
        set(app.EvalTypePopUp,'Value','Current Offset');
        set(app.SpanEltPPEdit,'Enable','on');
        set(app.GammaPPEdit,'Enable','on');
        set(app.CurrLoPPEdit,'Enable','on');
        set(app.CurrentPP,'Enable','on');
        set(app.NumOfRotorPosiPPEdit,'Enable','on');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','off');
        set(app.EvaluatedSpeedEdit,'Enable','off');
        set(app.StartPProMagnetPush,'Enable','off');
        set(app.StartPProAnsysPush,'Enable','off');
        set(app.MapQuadrantsPopUp,'Enable','off');
        set(app.Active3phasesetsEditField,'Enable','on');
        set(app.CustomCurrentSwitch,'Value','Off');     % no custom current
        set(app.AxistypeDropDown,'Enable','on');
        set(app.JMAGButton,'Enable','off')
    case 'force'
        set(app.EvalTypePopUp,'Value','Airgap Force');
        set(app.SpanEltPPEdit,'Enable','on');
        set(app.GammaPPEdit,'Enable','on');
        set(app.CurrLoPPEdit,'Enable','on');
        set(app.CurrentPP,'Enable','on');
        set(app.NumOfRotorPosiPPEdit,'Enable','on');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','off');
        set(app.EvaluatedSpeedEdit,'Enable','on');
        set(app.StartPProMagnetPush,'Enable','off');
        set(app.StartPProAnsysPush,'Enable','off');
        set(app.MapQuadrantsPopUp,'Enable','off');
        set(app.Active3phasesetsEditField,'Enable','on');
        set(app.CustomCurrentSwitch,'Value','Off');     % no custom current
        set(app.AxistypeDropDown,'Enable','on');
        set(app.JMAGButton,'Enable','off')
    case 'singtIron'
        set(app.EvalTypePopUp,'Value','Iron Loss - Single Point');
        set(app.SpanEltPPEdit,'Enable','on');
        set(app.GammaPPEdit,'Enable','on');
        set(app.CurrLoPPEdit,'Enable','on');
        set(app.CurrentPP,'Enable','on');
        set(app.NumOfRotorPosiPPEdit,'Enable','on');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','off');
        set(app.EvaluatedSpeedEdit,'Enable','on');
        set(app.StartPProMagnetPush,'Enable','on');
        set(app.StartPProAnsysPush,'Enable','on');
        set(app.MapQuadrantsPopUp,'Enable','off');
        set(app.Active3phasesetsEditField,'Enable','on');
        set(app.AxistypeDropDown,'Enable','on');
        set(app.JMAGButton,'Enable','on')
    case 'singmIron'
        set(app.EvalTypePopUp,'Value','Iron Loss - Flux Map');
        set(app.SpanEltPPEdit,'Enable','on');
        set(app.GammaPPEdit,'Enable','off');
        set(app.CurrLoPPEdit,'Enable','on');
        set(app.CurrentPP,'Enable','on');
        set(app.NumOfRotorPosiPPEdit,'Enable','on');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','on');
        set(app.EvaluatedSpeedEdit,'Enable','on');
        set(app.StartPProMagnetPush,'Enable','on');
        set(app.StartPProAnsysPush,'Enable','off');
        set(app.MapQuadrantsPopUp,'Enable','on');
        set(app.Active3phasesetsEditField,'Enable','on');
        set(app.CustomCurrentSwitch,'Value','Off');   % no custom current
        set(app.AxistypeDropDown,'Enable','on');
        set(app.JMAGButton,'Enable','on')
    case 'structural'
        set(app.EvalTypePopUp,'Value','Structural Analysis');
        set(app.SpanEltPPEdit,'Enable','off');
        set(app.GammaPPEdit,'Enable','off');
        set(app.CurrLoPPEdit,'Enable','off');
        set(app.CurrentPP,'Enable','off')
        set(app.NumOfRotorPosiPPEdit,'Enable','off');
        set(app.BrPPEdit,'Enable','off');
        set(app.TempPPEdit,'Enable','off');
        set(app.NGridPPEdit,'Enable','off');
        set(app.EvaluatedSpeedEdit,'Enable','on');
        set(app.StartPProMagnetPush,'Enable','off')
        set(app.StartPProAnsysPush,'Enable','off');
        set(app.MapQuadrantsPopUp,'Enable','off');
        set(app.Active3phasesetsEditField,'Enable','off');
        set(app.AxistypeDropDown,'Enable','off');
        set(app.JMAGButton,'Enable','off')
    case 'shortCircuit'
        set(app.EvalTypePopUp,'Value','HWC Short-Circuit Current');
        set(app.SpanEltPPEdit,'Enable','on');
        set(app.GammaPPEdit,'Enable','on');
        set(app.CurrLoPPEdit,'Enable','on');
        set(app.CurrentPP,'Enable','on')
        set(app.NumOfRotorPosiPPEdit,'Enable','on');
        set(app.BrPPEdit,'Enable','on');
        set(app.TempPPEdit,'Enable','on');
        set(app.NGridPPEdit,'Enable','off');
        set(app.EvaluatedSpeedEdit,'Enable','on');
        set(app.StartPProMagnetPush,'Enable','off');
        set(app.StartPProAnsysPush,'Enable','off');
        set(app.MapQuadrantsPopUp,'Enable','off');
        set(app.Active3phasesetsEditField,'Enable','off');
        set(app.CustomCurrentSwitch,'Value','Off');     % no custom current
        set(app.AxistypeDropDown,'Enable','on');
        set(app.JMAGButton,'Enable','off')
end

set(app.MeshEdit,'Value',num2str(dataSet.Mesh));
set(app.MeshMOOAEdit,'Value',num2str(dataSet.Mesh_MOOA));
set(app.mesh_kpmEdit,'Value',num2str(dataSet.mesh_kpm));

% set(app.CurrentPP,'Value',mat2str(dataSet.SimulatedCurrent))


%% Motor-CAD
%Build Thermal
set(app.InlettemperatureEditField,'Value',num2str(dataSet.InletTemperature));
set(app.HousingTypeDropDown,'Value',dataSet.HousingType);
set(app.FluidDropDown,'Value',dataSet.Fluid);
set(app.FluidFlowRateEditField,'Value',num2str(dataSet.FlowRate));
% Thermal Sim
set(app.ThermalevaluationtypeDropDown,'Value',dataSet.th_eval_type);
set(app.TransientperiodEditField,'Value',num2str(dataSet.TransientPeriod));
set(app.TimestepEditField,'Value',num2str(dataSet.TransientTimeStep));
set(app.InitialTemperatureEditField,'Value',num2str(dataSet.InitTemp));
set(app.AmbientTemperatureEditField,'Value',num2str(dataSet.AmbTemp));
set(app.EvaluatedSpeedMirrorEdit,'Value',num2str(dataSet.EvalSpeed));
% set(app.CurrentPPMirror,'Value',mat2str(round(dataSet.SimulatedCurrent,2)));
% set(app.GammaPPMirrorEdit,'Value',mat2str(dataSet.GammaPP));
% set(app.TempPPMirrorEdit,'Value',num2str(dataSet.tempPP));
set(app.CustomLossMCADCheck,'Value',dataSet.CustomLossMCADCheck);

%Thermal Limits
set(app.TempCuLimitEdit,'Value',num2str(dataSet.TempCuLimit));
set(app.TransientTimeEditField,'Value',num2str(dataSet.TransTime));
set(app.SimulatedRatedCurrent,'Enable','on','Value',num2str(dataSet.SimIth0),'Editable','off');
set(app.SimulatedTransientCurrent,'Enable','on','Value',num2str(dataSet.SimIthpk),'Editable','off');

%% Scaling
set(app.ScaleCheck,'Value',dataSet.ScaleCheck);
MNstate = get(app.StartPProMagnetPush,'Enable');

if dataSet.ScaleCheck
    % Main Data
    set(app.GapThiEdit,'Enable','off');
    set(app.AirGapRadiusEdit,'Enable','off');
    set(app.ShaftRadEdit,'Enable','off');
    set(app.PolePairsEdit,'Enable','off');
    set(app.NumOfSlotsEdit,'Enable','off');
    set(app.TypeOfRotorList,'Enable','off');
    set(app.StackLenghtEdit,'Enable','off');
    set(app.NumberofstatorslotsEditField,'Enable','off');
    set(app.Numberof3phasesetsEditField,'Enable','off');

    set(app.CustomLoad,'Enable','off');
    set(app.CustomClear,'Enable','off');
    set(app.StartPProPush,'Enable','off');
    set(app.StartPProMagnetPush,'Enable','off');
    set(app.ExportMCadPush,'Enable','off');
    set(app.SaveMachinePush,'Enable','off');
    set(app.SaveMachineMagnetPush,'Enable','off');
    set(app.DrawSlotModelPush,'Enable','off');
    set(app.EvalSlotModelPush,'Enable','off');
    set(app.OptimizePush,'Enable','off');

    children = get(app.GridLayout13,'Children');    % preliminary design
    set(children,'Enable','off');
    children = get(app.GridLayout15,'Children');    % stator panel
    set(children,'Enable','off');
    children = get(app.GridLayout16,'Children');    % rotor panel
    set(children,'Enable','off');
    children = get(app.GridLayout17,'Children');    % IM panel
    set(children,'Enable','off');
    children = get(app.GridLayout18,'Children');    % thermal panel
    set(children,'Enable','off');
    children = get(app.GridLayout20,'Children');    % mech control
    set(children,'Enable','off');
    children = get(app.GridLayout19,'Children');    % structural panel
    set(children,'Enable','off');
    if ~strcmp(dataSet.FluxBarrierMaterial,'Air')
        children = get(app.GridLayout26,'Children');    % PM panel
        set(children,'Enable','off');
    end
    children = get(app.GridLayout36,'Children');    % MCAD EM
    set(children,'Enable','off');
    children = get(app.GridLayout34,'Children');    % MCAD Thermal Build
    set(children,'Enable','off')
    children = get(app.GridLayout33,'Children');    % MCAD Thermal Sim
    set(children,'Enable','off');
else
    % Main Data
    set(app.GapThiEdit,'Enable','on');
    set(app.AirGapRadiusEdit,'Enable','on');
    set(app.ShaftRadEdit,'Enable','on');
    set(app.PolePairsEdit,'Enable','on');
    set(app.NumOfSlotsEdit,'Enable','on');
    set(app.TypeOfRotorList,'Enable','on');
    set(app.StackLenghtEdit,'Enable','on');
    set(app.CustomLoad,'Enable','on');
    set(app.CustomClear,'Enable','on');
    set(app.StartPProPush,'Enable','on');
    set(app.StartPProMagnetPush,'Enable',MNstate);
    set(app.ExportMCadPush,'Enable','on');
    set(app.SaveMachinePush,'Enable','on');
    set(app.SaveMachineMagnetPush,'Enable','on');
    set(app.DrawSlotModelPush,'Enable','on');
    set(app.EvalSlotModelPush,'Enable','on');
    set(app.OptimizePush,'Enable','on');
    set(app.NumberofstatorslotsEditField,'Enable','on');
    set(app.Numberof3phasesetsEditField,'Enable','on');

    if strcmp(app.CustomCurrentSwitch.Value,'On')
        set(app.StartPProPush,'Enable','on');
        set(app.StartPProMagnetPush,'Enable','off');
        set(app.StartPProAnsysPush,'Enable','on');
        set(app.CurrLoPPEdit,'Enable','off');
        set(app.GammaPPEdit,'Enable','off');
        set(app.CurrentPP,'Enable','off');
    end

    children = get(app.GridLayout13,'Children');    % preliminary design
    set(children,'Enable','on');
    children = get(app.GridLayout15,'Children');    % stator panel
    set(children,'Enable','on');
    children = get(app.GridLayout16,'Children');    % rotor panel
    set(children,'Enable','on');
    children = get(app.GridLayout17,'Children');    % IM panel
    set(children,'Enable','on');
    children = get(app.GridLayout18,'Children');    % thermal panel
    set(children,'Enable','on');
    children = get(app.GridLayout20,'Children');    % mech control
    set(children,'Enable','on');
    children = get(app.GridLayout19,'Children');    % structural panel
    set(children,'Enable','on');
    if ~strcmp(dataSet.FluxBarrierMaterial,'Air')
        children = get(app.GridLayout26,'Children');    % PM panel
        set(children,'Enable','on');
        if (strcmp(dataSet.TypeOfRotor,'Circular')||strcmp(dataSet.TypeOfRotor,'Vtype'))
            set(app.PMNcSegmentsTable,'Enable','off','ColumnEditable',false(1))
        end
    end
    children = get(app.GridLayout36,'Children');    % MCAD EM
    set(children,'Enable','on');
    children = get(app.GridLayout34,'Children');    % MCAD Thermal Build
    set(children,'Enable','on')
    children = get(app.GridLayout33,'Children');    % MCAD Thermal Sim
    set(children,'Enable','on');
end

set(app.SlotWidthEdit,'Enable','off');
set(app.YokeLengthEditField,'Enable','off');

if dataSet.custom
    set(app.ScaleCheck,'Enable','off');
else
    set(app.ScaleCheck,'Enable','on');
end




