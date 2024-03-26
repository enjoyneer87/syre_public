% '#'_______________________________________________________________
% '# Apply Iron loss condition on Iron Cores
function Iron_losscondition_JMAG (study,core_groupname,Core_LossName,PresetType,HysteresisLossCalcType,JouleLossCalcType)
        study.CreateCondition('Ironloss', Core_LossName);
        IronLoss_Condition_stator = study.GetCondition(Core_LossName);
        IronLoss_Condition_stator.SetName(Core_LossName);
        % --> Standard Calculation Method
        IronLoss_Condition_stator.SetValue('PresetType', PresetType); % 1 or Preset1; 2 or Preset2; 3 or Customize
        IronLoss_Condition_stator.SetValue('HysteresisLossCalcType', HysteresisLossCalcType);    % 1 or fft; 2 or loop; 3 or hysteresis_model; 4 or usersubroutine 
        IronLoss_Condition_stator.SetValue('JouleLossCalcType', JouleLossCalcType);         % 1 or fft; 2 or max; 3 or lamination_analysis; 4 or usersubroutine
        % % Basic frquency
        IronLoss_Condition_stator.SetValue('Poles', 'PolePair*2');
        IronLoss_Condition_stator.SetValue('RevolutionSpeed', 'rspeed');
        % % Reference settings
        IronLoss_Condition_stator.SetCoordinateSystem('CoordinateSystem', 'Global Rectangular');
        % % Stress Dependent
        % % User Subroutine
        % % Parts 
        IronLoss_Condition_stator.ClearParts();
        sel = IronLoss_Condition_stator.GetSelection();
        sel.SelectPart(core_groupname);
        IronLoss_Condition_stator.AddSelected(sel);
end


