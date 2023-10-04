function [eventCodes] = write_SessionEventCodeConfig_01(cfg)
%cfg.sessionPathName

if ~isfield(cfg, 'sessionPathName'), error('session path not defined'), end
if ~exist(cfg.sessionPathName), mkdir(cfg.sessionPathName), end
iPath = cfg.sessionPathName;

eventCodes = [];
eventCodes.SetupSessionEnds.Value = 1;
eventCodes.SetupSessionEnds.Description = 'Setup Session State Ends';
eventCodes.SelectTaskStarts.Value = 2;
eventCodes.SelectTaskStarts.Description = 'Select Task State Starts';
eventCodes.RunTaskStarts.Value = 3;
eventCodes.RunTaskStarts.Description = 'Run Task State Starts';
eventCodes.FinishSessionStarts.Value = 4;
eventCodes.FinishSessionStarts.Description = 'Finish Session State Starts';
eventCodes.CorrectResponse.Value = 5;
eventCodes.CorrectResponse.Description = 'Selected the Correct Object';
eventCodes.IncorrectResponse.Value = 6;
eventCodes.IncorrectResponse.Description = 'Failed to Select the Correct Object';
eventCodes.NoChoice.Value = 7;
eventCodes.NoChoice.Description = 'Trial Aborted Due to Object Selection Period Timing Out';
eventCodes.TouchDurationError.Value = 8;
eventCodes.TouchDurationError.Description = 'Did Not Maintain Object Selection For Minimum Duration, or Exceeded Max Duration';
eventCodes.SliderFbController_SliderCompleteFbOn.Value = 9;
eventCodes.SliderFbController_SliderCompleteFbOn.Description = 'Slider Complete feedback start'
eventCodes.SliderFbController_SliderCompleteFbOff.Value = 10;
eventCodes.SliderFbController_SliderCompleteFbOff.Description = 'Slider complete feedback termination';
eventCodes.SliderFbController_SliderReset.Value = 11;
eventCodes.SliderFbController_SliderReset.Description = 'Slider Reset';
 
% eventCodes.SyncBoxController_RewardPulseSent.Range = [11, 15];
% eventCodes.SyncBoxController_RewardPulseSent.Description = 'Reward Pulse Sent';
% eventCodes.SyncBoxController_SonicationPulseSent.Range = [16, 20];
% eventCodes.SyncBoxController_SonicationPulseSent.Description = 'Sonication Pulse Sent'
eventCodes.TokenFbController_FullTbAnimationStart.Value = 12;
eventCodes.TokenFbController_FullTbAnimationStart.Description = 'Token Bar Complete - Animation Begins';
eventCodes.TokenFbController_FullTbAnimationEnd.Value = 13;
eventCodes.TokenFbController_FullTbAnimationEnd.Description = 'Token Bar Complete - Animation Ends';
eventCodes.TokenFbController_TbReset.Value = 14;
eventCodes.TokenFbController_TbReset.Description = 'TokenBar Reset to Initial Value';

eventCodes.HaloFbController_SelectionVisualFbOn.Value = 15;
eventCodes.HaloFbController_SelectionVisualFbOn.Description = 'Selected object is highlighted to indicate accuracy';
eventCodes.HaloFbController_SelectionVisualFbOff.Value = 16;
eventCodes.HaloFbController_SelectionVisualFbOff.Description = 'highlighted object is no longer highlighted';
eventCodes.AudioFbController_SelectionAuditoryFbOn.Value = 17;
eventCodes.AudioFbController_SelectionAuditoryFbOn.Description = 'Auditory Feedback Played';

eventCodes.TouchFBController_FeedbackOn.Value = 18;
eventCodes.TouchFBController_FeedbackOn.Description = 'Touch Feedback On';
eventCodes.TouchFBController_FeedbackOff.Value = 19;
eventCodes.TouchFBController_FeedbackOff.Description = 'Touch Feedback Off';

eventCodes.SyncBoxController_RewardPulseSent.Range = [20, 29 ];
eventCodes.SyncBoxController_RewardPulseSent.Description = 'Reward Pulse Sent';

eventCodes.SyncBoxController_SonicationPulseSent.Range = [30, 39 ];
eventCodes.SyncBoxController_SonicationPulseSent.Description = 'Sonication Pulse Sent';

eventCodes.StimOn.Value = 40;
eventCodes.StimOn.Description = 'Stimulus Appears (followed by stim code)';
eventCodes.StimOff.Value = 41;
eventCodes.StimOff.Description = 'Stimulus Disappears (followed by stim code)';

eventCodes.TokenBarVisible.Value = 42;
eventCodes.TokenBarVisible.Description = 'TokenBar is Visible';



eventCodes.HoverOnObject.Value = 43;
eventCodes.HoverOnObject.Description = 'Hover On Object';
eventCodes.HoverOnTargetObject.Value = 44;
eventCodes.HoverOnTargetObject.Description = 'Hover On Target Object';
eventCodes.HoverOnDistractorObject.Value = 45;
eventCodes.HoverOnDistractorObject.Description = 'Hover On Distractor Object';
eventCodes.HoverOnIrrelevantObject.Value = 46;
eventCodes.HoverOnIrrelevantObject.Description = 'Hover On Irrelevant Object';
eventCodes.HoverOffObject.Value = 47;
eventCodes.HoverOffObject.Description = 'Hover Off Object ';
eventCodes.HoverOffTargetObject.Value = 48;
eventCodes.HoverOffTargetObject.Description = 'Hover Off Target Object';
eventCodes.HoverOffDistractorObject.Value = 49;
eventCodes.HoverOffDistractorObject.Description = 'Hover Off Distractor Object';
eventCodes.HoverOffIrrelevantObject.Value = 50;
eventCodes.HoverOffIrrelevantObject.Description = 'Hover Off Irrelevant Object';




eventCodes.Button0PressedOnObject.Value = 51;
eventCodes.Button0PressedOnObject.Description = 'Button 0 Pressed On Object';
eventCodes.Button0PressedOnTargetObject.Value = 52;
eventCodes.Button0PressedOnTargetObject.Description = 'Button 0 Pressed On Target Object';
eventCodes.Button0PressedOnDistractorObject.Value = 53;
eventCodes.Button0PressedOnDistractorObject.Description = 'Button 0 Pressed On Distractor Object';
eventCodes.Button0PressedOnIrrelevantObject.Value = 54;
eventCodes.Button0PressedOnIrrelevantObject.Description = 'Button 0 Pressed On Irrelevant Object';
eventCodes.Button0ReleasedFromObject.Value = 55;
eventCodes.Button0ReleasedFromObject.Description = 'Button 0 Pressed Off Object';
eventCodes.Button0ReleasedFromTargetObject.Value = 56;
eventCodes.Button0ReleasedFromTargetObject.Description = 'Button 0 Pressed Off Target Object';
eventCodes.Button0ReleasedFromDistractorObject.Value = 57;
eventCodes.Button0ReleasedFromDistractorObject.Description = 'Button 0 Pressed Off Distractor Object';
eventCodes.Button0ReleasedFromIrrelevantObject.Value = 58;
eventCodes.Button0ReleasedFromIrrelevantObject.Description = 'Button 0 Pressed Off Irrelevant Object';

eventCodes.Button1PressedOnObject.Value = 59;
eventCodes.Button1PressedOnObject.Description = 'Button 1 Pressed On Object';
eventCodes.Button1PressedOnTargetObject.Value = 60;
eventCodes.Button1PressedOnTargetObject.Description = 'Button 1 Pressed On Target Object';
eventCodes.Button1PressedOnDistractorObject.Value = 61;
eventCodes.Button1PressedOnDistractorObject.Description = 'Button 1 Pressed On Distractor Object';
eventCodes.Button1PressedOnIrrelevantObject.Value = 62;
eventCodes.Button1PressedOnIrrelevantObject.Description = 'Button 1 Pressed On Irrelevant Object';
eventCodes.Button1ReleasedFromObject.Value = 63;
eventCodes.Button1ReleasedFromObject.Description = 'Button 1 Pressed Off Object';
eventCodes.Button1ReleasedFromTargetObject.Value = 64;
eventCodes.Button1ReleasedFromTargetObject.Description = 'Button 1 Pressed Off Target Object';
eventCodes.Button1ReleasedFromDistractorObject.Value = 65;
eventCodes.Button1ReleasedFromDistractorObject.Description = 'Button 1 Pressed Off Distractor Object';
eventCodes.Button1ReleasedFromIrrelevantObject.Value = 66;
eventCodes.Button1ReleasedFromIrrelevantObject.Description = 'Button 1 Pressed Off Irrelevant Object';

eventCodes.Button2PressedOnObject.Value = 67;
eventCodes.Button2PressedOnObject.Description = 'Button 2 Pressed On Object';
eventCodes.Button2PressedOnTargetObject.Value = 68;
eventCodes.Button2PressedOnTargetObject.Description = 'Button 2 Pressed On Target Object';
eventCodes.Button2PressedOnDistractorObject.Value = 69;
eventCodes.Button2PressedOnDistractorObject.Description = 'Button 2 Pressed On Distractor Object';
eventCodes.Button2PressedOnIrrelevantObject.Value = 70;
eventCodes.Button2PressedOnIrrelevantObject.Description = 'Button 2 Pressed On Irrelevant Object';
eventCodes.Button2ReleasedFromObject.Value = 71;
eventCodes.Button2ReleasedFromObject.Description = 'Button 2 Pressed Off Object';
eventCodes.Button2ReleasedFromTargetObject.Value = 72;
eventCodes.Button2ReleasedFromTargetObject.Description = 'Button 2 Pressed Off Target Object';
eventCodes.Button2ReleasedFromDistractorObject.Value = 73;
eventCodes.Button2ReleasedFromDistractorObject.Description = 'Button 2 Pressed Off Distractor Object';
eventCodes.Button2ReleasedFromIrrelevantObject.Value = 74;
eventCodes.Button2ReleasedFromIrrelevantObject.Description = 'Button 2 Pressed Off Irrelevant Object';


eventCodes.ObjectSelected.Value = 74;
eventCodes.ObjectSelected.Description = 'Object Selected';
eventCodes.TargetObjectSelected.Value = 75;
eventCodes.TargetObjectSelected.Description = 'Target Object Selected';
eventCodes.DistractorObjectSelected.Value = 76;
eventCodes.DistractorObjectSelected.Description = 'Distractor Object Selected';

eventCodes.IrrelevantObjectSelected.Description = 'Irrelevant Object Selected';
eventCodes.IrrelevantObjectSelected.Value = 78;
eventCodes.StartButtonSelected.Description = 'Start Button Selected';
eventCodes.StartButtonSelected.Value = 79;

eventCodes.ContextOn.Value = 80;
eventCodes.ContextOn.Description = 'Context On';
eventCodes.ContextOff.Value = 81;
eventCodes.ContextOff.Description = 'Context Off';

eventCodes.InstructionsOn.Value = 82;
eventCodes.InstructionsOn.Description = 'Instructions On';
eventCodes.InstructionsOff.Value = 83;
eventCodes.InstructionsOff.Description = 'Instructions Off';

eventCodes.HumanStartPanelOn.Value = 84;
eventCodes.HumanStartPanelOn.Description = 'HumanStartPanel On';
eventCodes.HumanStartPanelOff.Value = 85;
eventCodes.HumanStartPanelOff.Description = 'HumanStartPanel Off';


eventCodes.SetupTaskStarts.Range = [ 101, 130 ];
eventCodes.SetupTaskStarts.Description = 'Setup Task State Starts';
eventCodes.RunBlockStarts.Range = [ 201, 300 ];
eventCodes.RunBlockStarts.Description = 'Run Block State Starts';
eventCodes.BlockFeedbackStarts.Value = 301;
eventCodes.BlockFeedbackStarts.Description = 'Block Feedback State Starts';
eventCodes.FinishTaskStarts.Value = 302;
eventCodes.FinishTaskStarts.Description = 'Finish Task State Starts';
%eventCodes.BlockTerminates.Range = [ 311, 330 ];
%eventCodes.BlockTerminates.Description = 'Block Terminates';

eventCodes.SetupTrialStarts.Range = [ 1001, 6000 ];
eventCodes.SetupTrialStarts.Description = ' [1001, 6000] Setup Trial State Starts ';

eventCodes.FinishTrialStarts.Value = 7001;
eventCodes.FinishTrialStarts.Description = 'Finish Trial State Starts ';
eventCodes.GenericError.Value = 8001;
eventCodes.GenericError.Description = 'Generic Error';
eventCodes.CustomError.Range = [ 8002, 8100 ];
eventCodes.CustomError.Description = '8002, 8100 indicate Custom Error';
eventCodes.GenericAbortTrial.Value = 9001;
eventCodes.GenericAbortTrial.Description = 'Generic Abort Trial';
eventCodes.CustomAbortTrial.Range = [ 9002, 9100 ];
eventCodes.CustomAbortTrial.Description = 'Custom Abort Trial';

eventCodes.GenericObject.Value = 10000;
eventCodes.GenericObject.Description = 'Generic Object';

eventCodes.Quaddle.Range = [ 10001, 19000 ];
eventCodes.Quaddle.Description = '10001, 19000 indicates Quaddle identity';

eventCodes.SpecificObject.Range = [ 19001, 19999 ];
eventCodes.SpecificObject.Description = '19001, 19999 indicates Specific Object';

%jsonData.TrialNumber.Range = [4000, 5999];
%    jsonData.TrialNumber.Description = '4000-5999 indicates TrialNumber, which only iterates if trial is not aborted. Most interesting data only occurs when this iterates.';

%eventCodes.TouchFBController_FeedbackOn.Value = 73;
%eventCodes.TouchFBController_FeedbackOn.Description = 'Touch Feedback On';
%eventCodes.TouchFBController_FeedbackOff.Value = 74;
%eventCodes.TouchFBController_FeedbackOff.Description = 'Touch Feedback Off';


%eventCodes.SelectionHandler_TouchErrorImageOn.Value = 29;
%eventCodes.SelectionHandler_TouchErrorImageOn.Description = 'Vertial Lines Shown for Not Sufficiently Maintaining Selection';
%eventCodes.SelectionHandler_TouchErrorImageOff.Value = 30;
%eventCodes.SelectionHandler_TouchErrorImageOff.Description = 'Vertical Lines from Touch Error are Removed';





eventCodesString=jsonencode(eventCodes,'PrettyPrint',true);

iFilename = 'SessionEventCodeConfig';

fPtr = fopen([iPath filesep iFilename '_json.json'],'w');
fprintf(fPtr, '%s', eventCodesString);
fclose(fPtr);
fprintf('\n wrote %s\n ', [ iFilename ]);



