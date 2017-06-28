object FormSettings: TFormSettings
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Settings'
  ClientHeight = 133
  ClientWidth = 373
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl: TPageControl
    Left = 0
    Top = 0
    Width = 373
    Height = 133
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Save paths'
      object LabelMarkers: TLabel
        Left = 16
        Top = 51
        Width = 38
        Height = 13
        Caption = 'Markers'
      end
      object Masks: TLabel
        Left = 16
        Top = 78
        Width = 29
        Height = 13
        Caption = 'Masks'
      end
      object EditSavePathMasks: TEdit
        Left = 80
        Top = 75
        Width = 265
        Height = 21
        TabOrder = 2
        OnKeyPress = EditSavePathMasksKeyPress
      end
      object RadioGroupRelativeTo: TRadioGroup
        Left = 16
        Top = 5
        Width = 329
        Height = 37
        Caption = 'Save paths relative to'
        Columns = 2
        Items.Strings = (
          'Application'
          'Image')
        TabOrder = 0
      end
      object EditSavePathMarkers: TEdit
        Left = 80
        Top = 48
        Width = 265
        Height = 21
        TabOrder = 1
        OnKeyPress = EditSavePathMarkersKeyPress
      end
    end
    object TabSheet2: TTabSheet
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Caption = 'Dot Marker'
      ImageIndex = 1
      object PanelDotMarker: TPanel
        Left = 0
        Top = 0
        Width = 365
        Height = 105
        Align = alClient
        BevelOuter = bvNone
        Caption = 'PanelDotMarker'
        ShowCaption = False
        TabOrder = 0
        ExplicitLeft = -8
        ExplicitTop = -28
        ExplicitWidth = 373
        ExplicitHeight = 133
        object LabelDotMarkerColor: TLabel
          Left = 12
          Top = 15
          Width = 25
          Height = 13
          Caption = 'Color'
        end
        object LabelDotMarkerStrokeLength: TLabel
          Left = 12
          Top = 71
          Width = 64
          Height = 13
          Caption = 'Stroke length'
        end
        object LabelDotMarkerStrokeWidth: TLabel
          Left = 12
          Top = 43
          Width = 60
          Height = 13
          Caption = 'Stroke width'
        end
        object ImageDotMarker: TImage
          Left = 268
          Top = 12
          Width = 78
          Height = 78
        end
        object EditDotMarkerColor: TColorBox
          Left = 100
          Top = 12
          Width = 145
          Height = 22
          TabOrder = 0
          OnChange = ActionDrawDotMarkerExecute
        end
        object EditDotMarkerStrokeWidth: TSpinEdit
          Left = 100
          Top = 40
          Width = 145
          Height = 23
          MaxValue = 100
          MinValue = 1
          TabOrder = 1
          Value = 1
          OnChange = ActionDrawDotMarkerExecute
        end
        object EditDotMarkerStrokeLength: TSpinEdit
          Left = 100
          Top = 68
          Width = 145
          Height = 23
          MaxValue = 100
          MinValue = 1
          TabOrder = 2
          Value = 1
          OnChange = ActionDrawDotMarkerExecute
        end
      end
    end
  end
  object ActionList: TActionList
    Left = 184
    object ActionShowSettings: TAction
      Caption = 'Show Settings'
      OnExecute = ActionShowSettingsExecute
    end
    object ActionDrawDotMarker: TAction
      Caption = 'ActionDrawDotMarker'
      OnExecute = ActionDrawDotMarkerExecute
    end
  end
end
