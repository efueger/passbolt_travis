﻿package {
	// Simple Set Clipboard System
	// Author: Joseph Huckaby
	
	import flash.display.Stage;
	import flash.display.Sprite;
	import flash.desktop.Clipboard;
	import flash.desktop.ClipboardFormats;
	import flash.desktop.ClipboardTransferMode;
	import flash.display.LoaderInfo;
	import flash.display.StageScaleMode;
	import flash.events.*;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.external.ExternalInterface;
	import flash.system.Security;
	import flash.utils.*;
	import flash.system.System;
	import flash.display.SimpleButton;
 
	public class ZeroClipboard10 extends Sprite {
		
		private var id:String = '';
		private var button:Sprite;
		private var clipText:String = '';
		
		public function ZeroClipboard10() {
			// constructor, setup event listeners and external interfaces
			//stage.scaleMode = StageScaleMode.EXACT_FIT;
			flash.system.Security.allowDomain("*");
			
			// import flashvars
			var flashvars:Object = LoaderInfo( this.root.loaderInfo ).parameters;
			id = flashvars.id;
			
			// invisible button covers entire stage
			button = new Sprite();
			button.buttonMode = true;
			button.useHandCursor = true;
			button.graphics.beginFill(0xCCFF00);
			button.graphics.drawRect(0, 0, Math.floor(flashvars.width), Math.floor(flashvars.height));
			button.alpha = 0.0;
			addChild(button);
			button.addEventListener(MouseEvent.CLICK, clickHandler);
			
			button.addEventListener(MouseEvent.MOUSE_OVER, function(event:Event) {
				ExternalInterface.call( 'ZeroClipboard.dispatch', id, 'mouseOver', null );
			} );
			button.addEventListener(MouseEvent.MOUSE_OUT, function(event:Event) {
				ExternalInterface.call( 'ZeroClipboard.dispatch', id, 'mouseOut', null );
			} );
			button.addEventListener(MouseEvent.MOUSE_DOWN, function(event:Event) {
				ExternalInterface.call( 'ZeroClipboard.dispatch', id, 'mouseDown', null );
			} );
			button.addEventListener(MouseEvent.MOUSE_UP, function(event:Event) {
				ExternalInterface.call( 'ZeroClipboard.dispatch', id, 'mouseUp', null );
			} );
			
			// external functions
			ExternalInterface.addCallback("setHandCursor", setHandCursor);
			ExternalInterface.addCallback("setText", setText);
			
			// signal to the browser that we are ready
			ExternalInterface.call( 'ZeroClipboard.dispatch', id, 'load', null );
		}
		
		public function setText(newText) {
			// set the maximum number of files allowed
			clipText = newText;
		}
		
		public function setHandCursor(enabled:Boolean) {
			// control whether the hand cursor is shown on rollover (true)
			// or the default arrow cursor (false)
			button.useHandCursor = enabled;
		}
		
		public function sendRequete():String{
			var resultRequest = "Gimme gimme a man after midnight";
			return resultRequest;
		}
		
		private function clickHandler(event:Event):void {
			// user click copies text to clipboard
			// as of flash player 10, this MUST happen from an in-movie flash click event
			if(clipText != "2"){
				Clipboard.generalClipboard.clear();
				Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, clipText);
				Clipboard.generalClipboard.setData(ClipboardFormats.HTML_FORMAT, clipText);
				ExternalInterface.call( 'ZeroClipboard.dispatch', id, 'complete', clipText );
			}else{
				clipText = sendRequest();
				trace(sendRequest())
				Clipboard.generalClipboard.clear();
				Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT, clipText);
				Clipboard.generalClipboard.setData(ClipboardFormats.HTML_FORMAT, clipText);
				ExternalInterface.call( 'ZeroClipboard.dispatch', id, 'complete', clipText );
			}
		}
	}
}