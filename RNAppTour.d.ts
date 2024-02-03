
export type AppTourViewPropType = {
  /** string: HEX-COLOR 	UIColor.blue 	Specify background prompt color */
  backgroundPromptColor?: string;
  /** number: 	0.96 	Specify background prompt color alpha */
  backgroundPromptColorAlpha?: number;
  /** left 	Specify primary text alignment: Left, Right, Top, Bottom */
  titleTextAlignment?: 'left' | 'right' | 'top' | 'bottom';
  /** left 	Specify secondary text alignment: Left, Right, Top, Bottom */
  descriptionTextAlignment?: 'left' | 'right' | 'top' | 'bottom';
  /** number :	0.5 	Specify animation come In Duration */
  aniComeInDuration?: number;
  //** number :	1.5 Specify animation Go Out Duration */
  aniGoOutDuration?: number;
  //** string: HEX-COLOR 	#FFFFFF 	Specify ripple color */
  aniRippleColor?: string;
  //** number :	0.2 	Specify ripple alpha */
  aniRippleAlpha?: number;
  //** mandatory 	bool 		Specify collapsable false if your view just contains children. Please read view#collapsable for the details */
  collapsable?: boolean;
  //** number: 	0.96f 	Specify the alpha amount for the outer circle */
  outerCircleAlpha?: number;
  //** string: HEX-COLOR 		Specify a color for both the title and description text */
  textColor?: string;
  //** string: HEX-COLOR 		If set, will dim behind the view with 30% opacity of the given color */
  dimColor?: string;
  //**  	true 	Whether to draw a drop shadow or not */
  drawShadow?: boolean;
  //** 	true 	Whether to tint the target view's color */
  tintTarget?: boolean;
  //** 	true 	Specify whether the target is transparent (displays the content underneath) */
  transparentTarget?: boolean;

  //**  mandatory 	number 		Specify the order of tour target */
  order?: number;
  //** 	Specify the title of tour */
  title?: string;
  //** 		Specify the description of tour */
  description?: string;
  //**  string: HEX-COLOR 		Specify a color for the outer circle */
  outerCircleColor?: string;
  //**  string: HEX-COLOR 		Specify a color for the target circle */
  targetCircleColor?: string;
  //**  20 	Specify the size (in sp) of the title text */
  titleTextSize?: number;
  //**  string: HEX-COLOR 		Specify the color of the title text */
  titleTextColor?: string;
  //** 	10 	Specify the size (in sp) of the description text */
  descriptionTextSize?: number;//  
  //**  string: HEX-COLOR 		Specify the color of the description text */
  descriptionTextColor?: string;
  //** 	60 	Specify the target radius (in dp) */
  targetRadius?: number;
  //** 	true 	Whether tapping anywhere dismisses the view */
  cancelable?: boolean;
}

declare interface AppTourViewType {
  key: any,
  view: any,
  props: AppTourViewPropType
}

declare class AppTour {
  static ShowSequence(sequence: AppTourSequence): void;

  static ShowFor(appTourTarget: AppTourViewType): void;
}

declare class AppTourSequence {
  add(appTourTarget: AppTourView): void;
  remove(appTourTarget: AppTourView): void;
  removeAll(): void;;
  get(appTourTarget: AppTourView): AppTourView;
  getAll(): MapConstructor;
}

declare class AppTourView {
  static for(view: any, props: any): AppTourViewType;
}

export { AppTourView, AppTourSequence, AppTour, AppTourViewPropType }
