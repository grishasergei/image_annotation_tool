object CrowdAnnotationForm: TCrowdAnnotationForm
  Left = 0
  Top = 0
  Caption = 'Crowd Annotation Tool'
  ClientHeight = 466
  ClientWidth = 966
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object PanelTop: TPanel
    Left = 0
    Top = 0
    Width = 966
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    Caption = 'PanelTop'
    ShowCaption = False
    TabOrder = 0
    Visible = False
  end
  object PanelLeft: TPanel
    Left = 0
    Top = 35
    Width = 89
    Height = 390
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'PanelLeft'
    ShowCaption = False
    TabOrder = 1
    ExplicitTop = 41
    object ButtonOpenImage: TButton
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 83
      Height = 30
      Action = ImageOpen
      Align = alTop
      TabOrder = 0
    end
    object ButtonSave: TButton
      AlignWithMargins = True
      Left = 3
      Top = 75
      Width = 83
      Height = 30
      Action = ActionSaveCurrentAnnotation
      Align = alTop
      TabOrder = 1
      ExplicitTop = 39
    end
    object ButtonSaveAll: TButton
      AlignWithMargins = True
      Left = 3
      Top = 111
      Width = 83
      Height = 30
      Action = ActionSaveAllAnnotations
      Align = alTop
      TabOrder = 2
      ExplicitTop = 75
    end
    object ButtonClearMarkers: TButton
      AlignWithMargins = True
      Left = 3
      Top = 147
      Width = 83
      Height = 30
      Action = ActionClearMarkers
      Align = alTop
      TabOrder = 3
      ExplicitTop = 111
    end
    object ButtonLoadAnnotations: TButton
      AlignWithMargins = True
      Left = 3
      Top = 39
      Width = 83
      Height = 30
      Action = ActionLoadAnnotations
      Align = alTop
      TabOrder = 4
      ExplicitTop = 15
    end
  end
  object PanelCenter: TPanel
    Left = 89
    Top = 35
    Width = 675
    Height = 390
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    object GridPanelCenterBottom: TGridPanel
      AlignWithMargins = True
      Left = 3
      Top = 349
      Width = 669
      Height = 38
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'GridPanelCenterBottom'
      ColumnCollection = <
        item
          Value = 20.000000000000000000
        end
        item
          Value = 20.000000000000000000
        end
        item
          Value = 20.000000000000000000
        end
        item
          Value = 20.000000000000000000
        end
        item
          Value = 20.000000000000000000
        end>
      ControlCollection = <
        item
          Column = 1
          Control = ButtonPrevImage
          Row = 0
        end
        item
          Column = 3
          Control = ButtonNextImage
          Row = 0
        end
        item
          Column = 2
          Control = LabelImageCount
          Row = 0
        end>
      ParentBackground = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end
        item
          SizeStyle = ssAuto
        end>
      ShowCaption = False
      TabOrder = 0
      object ButtonPrevImage: TButton
        AlignWithMargins = True
        Left = 136
        Top = 3
        Width = 127
        Height = 32
        Action = ActionPreviousImage
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsStrikeOut]
        ParentFont = False
        TabOrder = 0
      end
      object ButtonNextImage: TButton
        AlignWithMargins = True
        Left = 402
        Top = 3
        Width = 127
        Height = 32
        Action = ActionNextImage
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = [fsBold, fsStrikeOut]
        ParentFont = False
        TabOrder = 1
      end
      object LabelImageCount: TLabel
        AlignWithMargins = True
        Left = 269
        Top = 3
        Width = 127
        Height = 32
        Align = alClient
        Alignment = taCenter
        Layout = tlCenter
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
    end
    object GridPanelCenterTop: TGridPanel
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 669
      Height = 25
      Align = alTop
      BevelOuter = bvNone
      Caption = 'GridPanelCenterTop'
      Color = clAppWorkSpace
      ColumnCollection = <
        item
          Value = 25.000000000000000000
        end
        item
          Value = 50.000000000000000000
        end
        item
          Value = 12.500000000000000000
        end
        item
          Value = 12.500000000000000000
        end>
      ControlCollection = <
        item
          Column = 1
          Control = LabelCurrentImageFullName
          Row = 0
        end
        item
          Column = 0
          Control = PanelModeButtons
          Row = 0
        end
        item
          Column = 3
          Control = ButtonCloseCurrentImage
          Row = 0
        end>
      ParentBackground = False
      RowCollection = <
        item
          Value = 100.000000000000000000
        end>
      ShowCaption = False
      TabOrder = 1
      object LabelCurrentImageFullName: TLabel
        AlignWithMargins = True
        Left = 170
        Top = 3
        Width = 328
        Height = 19
        Align = alClient
        Alignment = taCenter
        Layout = tlCenter
        ExplicitWidth = 3
        ExplicitHeight = 13
      end
      object PanelModeButtons: TPanel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 167
        Height = 25
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        BevelOuter = bvNone
        Caption = 'PanelModeButtons'
        ShowCaption = False
        TabOrder = 0
        object ButtonCombinedMode: TSpeedButton
          AlignWithMargins = True
          Left = 1
          Top = 3
          Width = 53
          Height = 19
          Margins.Left = 1
          Margins.Right = 1
          Align = alLeft
          GroupIndex = 2
          Down = True
          Caption = 'Combined'
          OnClick = ActionPresentationModeCombinedExecute
        end
        object ButtonMaskMode: TSpeedButton
          AlignWithMargins = True
          Left = 111
          Top = 3
          Width = 53
          Height = 19
          Margins.Left = 1
          Margins.Right = 1
          Align = alLeft
          GroupIndex = 2
          Caption = 'Mask'
          OnClick = ActionPresentationModeMaskExecute
        end
        object ButtonOriginalMode: TSpeedButton
          AlignWithMargins = True
          Left = 56
          Top = 3
          Width = 53
          Height = 19
          Margins.Left = 1
          Margins.Right = 1
          Align = alLeft
          GroupIndex = 2
          Caption = 'Original'
          OnClick = ActionPresentationModeOriginalExecute
        end
      end
      object ButtonCloseCurrentImage: TButton
        AlignWithMargins = True
        Left = 626
        Top = 3
        Width = 40
        Height = 19
        Action = ActionCloseCurrentImage
        Align = alRight
        TabOrder = 1
      end
    end
    object PanelImageContainer: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 34
      Width = 669
      Height = 309
      Align = alClient
      BevelOuter = bvNone
      Caption = 'Open an image'
      Color = clAppWorkSpace
      ParentBackground = False
      TabOrder = 2
      object ImageContainer: TImage
        Left = 0
        Top = 0
        Width = 669
        Height = 309
        Cursor = crCross
        Align = alClient
        Center = True
        Proportional = True
        OnMouseDown = ImageContainer_MouseDown
        ExplicitLeft = 400
        ExplicitTop = 160
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
  end
  object PanelRight: TPanel
    Left = 764
    Top = 35
    Width = 202
    Height = 390
    Align = alRight
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 3
    object LabelHistoryCaption: TLabel
      AlignWithMargins = True
      Left = 3
      Top = 83
      Width = 196
      Height = 13
      Align = alTop
      Caption = 'Edit History'
      ExplicitWidth = 55
    end
    object PanelImageInfo: TPanel
      Left = 0
      Top = 0
      Width = 202
      Height = 80
      Align = alTop
      BevelOuter = bvNone
      Caption = 'PanelImageInfo'
      ShowCaption = False
      TabOrder = 0
      object PanelCaptions: TPanel
        Left = 0
        Top = 0
        Width = 49
        Height = 80
        Align = alLeft
        BevelOuter = bvNone
        Caption = 'PanelCaptions'
        ShowCaption = False
        TabOrder = 0
        object Label1: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 41
          Width = 43
          Height = 13
          Align = alTop
          Caption = 'Height'
          ExplicitWidth = 31
        end
        object Label2: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 43
          Height = 13
          Align = alTop
          Caption = 'Name'
          ExplicitWidth = 27
        end
        object Label3: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 22
          Width = 43
          Height = 13
          Align = alTop
          Caption = 'Width'
          ExplicitWidth = 28
        end
      end
      object PanelValues: TPanel
        Left = 49
        Top = 0
        Width = 153
        Height = 80
        Align = alClient
        BevelOuter = bvNone
        Caption = 'PanelValues'
        ShowCaption = False
        TabOrder = 1
        object LabelImageHeight: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 41
          Width = 147
          Height = 13
          Align = alTop
          ExplicitWidth = 3
        end
        object LabelImageWidth: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 22
          Width = 147
          Height = 13
          Align = alTop
          ExplicitWidth = 3
        end
        object LabelImageName: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 147
          Height = 13
          Align = alTop
          ExplicitWidth = 3
        end
      end
    end
    object ListBoxHistory: TListBox
      AlignWithMargins = True
      Left = 3
      Top = 102
      Width = 196
      Height = 285
      Style = lbOwnerDrawFixed
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clBtnFace
      TabOrder = 1
      OnClick = ListBoxHistoryClick
      OnDrawItem = ListBoxHistoryDrawItem
    end
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 425
    Width = 966
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 4
    Visible = False
  end
  object ActionList: TActionList
    Left = 281
    Top = 211
    object ImageOpen: TFileOpen
      Category = 'File'
      Caption = '&Open...'
      Dialog.Filter = 'Images|*.jpg;*.jpeg;*.png;*.PNG;*.bmp'
      Dialog.Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
      OnAccept = ImageOpenAccept
    end
    object ActionToggleMarkers: TAction
      Caption = 'Toggle Markers'
    end
    object ActionSaveCurrentAnnotation: TAction
      Caption = 'Save'
      ShortCut = 16467
      OnExecute = ActionSaveCurrentAnnotationExecute
    end
    object ActionPreviousImage: TAction
      Caption = '<--'
      OnExecute = ActionPreviousImageExecute
    end
    object ActionNextImage: TAction
      Caption = '-->'
      OnExecute = ActionNextImageExecute
    end
    object ActionSaveAllAnnotations: TAction
      Caption = 'Save all'
      OnExecute = ActionSaveAllAnnotationsExecute
    end
    object ActionClearMarkers: TAction
      Caption = 'Clear markers'
      OnExecute = ActionClearMarkersExecute
    end
    object ActionPresentationModeCombined: TAction
      Caption = 'Combined'
      OnExecute = ActionPresentationModeCombinedExecute
    end
    object ActionPresentationModeOriginal: TAction
      Caption = 'Original'
      OnExecute = ActionPresentationModeOriginalExecute
    end
    object ActionPresentationModeMask: TAction
      Caption = 'Mask'
      OnExecute = ActionPresentationModeMaskExecute
    end
    object ActionCloseCurrentImage: TAction
      Caption = 'Close'
      OnExecute = ActionCloseCurrentImageExecute
    end
    object ActionLoadAnnotations: TFileOpen
      Category = 'File'
      Caption = 'Annotations...'
      Dialog.Filter = 'JSON|*.txt'
      Hint = 'Open|Opens an existing file'
      ImageIndex = 7
      ShortCut = 16463
      OnAccept = ActionLoadAnnotationsAccept
    end
  end
end
