package org.igazine.security
{
	/**
	 * ...
	 * @author Tamas Sopronyi, igazine.org
	 */
	
	import flash.net.SharedObject;
	import flash.system.Capabilities;
	import flash.system.Security;
	import flash.system.System;
	import flash.text.Font;
	import flash.text.FontType;
	import flash.utils.ByteArray;
	import com.adobe.crypto.MD5;
	
	public class FSecurity 
	{
		
		public static var userServerString:Boolean;
		public static var includeFonts:Boolean = true;
		public static var includeTimeZoneOffset:Boolean = true;
		public static var includeFlashVersion:Boolean;
		public static var includePlayerType:Boolean;
		public static var includeAccessibility:Boolean;
		public static var includeEmbeddedInAcrobat:Boolean;
		public static var includeIsDebugger:Boolean;
		public static var excludedFontNames:Array = [];
		
		public static const METHOD_MD5:String = "MD5";
		
		public function FSecurity() {}
		
		public static function fingerPrint( method:String = METHOD_MD5 ):String {
			var ba:ByteArray = new ByteArray();
			var result:String;
			ba.writeObject( getFingerPrintObject() );
			switch ( method ) {
				case METHOD_MD5:
					result = MD5.hashBytes ( ba );
					break;
				default:
					result = MD5.hashBytes ( ba );
					break;
			}
			return result;
		}
		
		private static function getFingerPrintObject():Array {
			var result:Array = [ ];
			if ( includeFonts ) result.push(getFontList());
			result.push(getServerString());
			if ( includeTimeZoneOffset ) result.push( new Date().timezoneOffset );
			return result;
		}
		
		private static function getServerString():Array {
			var a:Array = [];
			if ( userServerString ) {
				a.push( Capabilities.serverString );
			} else {
				a.push( String(Capabilities.avHardwareDisable) );
				a.push( String(Capabilities.cpuArchitecture) );
				a.push( String(Capabilities.cpuArchitecture) );
				a.push( String(Capabilities.hasAudio) );
				a.push( String(Capabilities.hasAudioEncoder) );
				a.push( String(Capabilities.hasEmbeddedVideo) );
				a.push( String(Capabilities.hasIME) );
				a.push( String(Capabilities.hasMP3) );
				a.push( String(Capabilities.hasPrinting) );
				a.push( String(Capabilities.hasScreenBroadcast) );
				a.push( String(Capabilities.hasScreenPlayback) );
				a.push( String(Capabilities.hasStreamingAudio) );
				a.push( String(Capabilities.hasStreamingVideo) );
				a.push( String(Capabilities.hasTLS) );
				a.push( String(Capabilities.hasVideoEncoder) );
				a.push( String(Capabilities.language) );
				a.push( String(Capabilities.localFileReadDisable) );
				a.push( String(Capabilities.manufacturer) );
				a.push( String(Capabilities.maxLevelIDC) );
				a.push( String(Capabilities.os) );
				a.push( String(Capabilities.pixelAspectRatio) );
				a.push( String(Capabilities.screenColor) );
				a.push( String(Capabilities.screenDPI) );
				a.push( String(Capabilities.screenResolutionX) );
				a.push( String(Capabilities.screenResolutionY) );
				a.push( String(Capabilities.supports32BitProcesses) );
				a.push( String(Capabilities.supports64BitProcesses) );
				a.push( String(Capabilities.touchscreenType) );
				if ( includePlayerType ) a.push( String(Capabilities.playerType) );
				if ( includeAccessibility ) a.push( String(Capabilities.hasAccessibility) );
				if ( includeFlashVersion ) a.push( String(Capabilities.version) );
				if ( includeEmbeddedInAcrobat ) a.push( String(Capabilities.isEmbeddedInAcrobat) );
				if ( includeIsDebugger ) a.push( String(Capabilities.isDebugger) );
			}
			return a;
		}
		
		private static function fontNameFilter(o:Object, index:int, array:Array):Boolean {
			var hasIt:Boolean;
			for ( var j:int = 0; j < excludedFontNames.length; j++ ) {
				if ( o.fontName.toLowerCase().search( excludedFontNames[j] ) != -1 ) {
					hasIt = true;
					break;
				}
			}
			return !hasIt;
		}
		
		private static function fontTypeFilter(o:Object, index:int, array:Array):Boolean {
			return ( o.fontType == FontType.DEVICE );
		}
		
		private static function getFontList():Array {
			var b:Array = Font.enumerateFonts(true).filter(fontNameFilter).filter(fontTypeFilter).sortOn("fontName", Array.CASEINSENSITIVE);
			return b;
		}
		
		public static function getUniqueId( soName:String = "/org/igazine/security/FSecurity", propertyName:String = "uniqueId", secure:Boolean = false ):Number {
			var s:Number;
			var so:SharedObject = SharedObject.getLocal( soName, "/", secure );
			if ( so.data[propertyName] ) return so.data[propertyName];
			s = Number ( new Date().time + Math.random() );
			so.setProperty( propertyName, s );
			return s;
		}
		
	}

}