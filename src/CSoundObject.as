package
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	import com.greensock.TweenMax;
	
	/**
	 * ...
	 * @author Kurniawan Fitriadi
	 */
	public class CSoundObject
	{
		private var m_sound:Sound;
		private var m_soundChannel:SoundChannel;
		private var m_isMusic:Boolean;
		private var m_isLoop:Boolean;
		private var m_isPlaying:Boolean;
		private var m_sfxGroup:String;
		
		public function CSoundObject(sound:Sound, isMusicData:Boolean=false) 
		{
			m_sound = sound;
			m_isMusic = isMusicData;
			m_isPlaying = false;
		}
		
		public function set group(value:String):void
		{
			m_sfxGroup = value;
		}
		
		public function get group():String
		{
			return m_sfxGroup;
		}
		
		public function play(loop:int, transformer:SoundTransform):void
		{
			m_soundChannel = m_sound.play(0, loop, transformer);
			
			// add listener
			if( m_isMusic )
				SoundManager.getInstance().addEventListener(SoundManager.MUSIC_VOLUME, volumeChanged);
				
			if ( m_soundChannel )	// FIXME
			{
				m_soundChannel.addEventListener(Event.SOUND_COMPLETE, onSoundComplete);
				if( m_sfxGroup != "" )
					SoundManager.getInstance().setGroupStatus(m_sfxGroup, true);
			
				m_isPlaying = true;
			}
		}
		
		private function volumeChanged(event:SoundEvent):void
		{
			var transform:SoundTransform = m_soundChannel.soundTransform;
            transform.volume = event.volume;
			
			if ( m_soundChannel )	// FIXME
			{
				m_soundChannel.soundTransform = transform;
			}
		}
		
		private function onSoundComplete(event:Event = null):void
		{
			m_isPlaying = false;
			if ( m_soundChannel )	// FIXME
			{
				m_soundChannel.removeEventListener(Event.SOUND_COMPLETE, onSoundComplete);
			}
			
			if( m_isMusic )
				SoundManager.getInstance().removeEventListener(SoundManager.MUSIC_VOLUME, volumeChanged);
				
			if( m_sfxGroup != "" )
				SoundManager.getInstance().setGroupStatus(m_sfxGroup, false);	
		}
		
		public function isPlaying():Boolean
		{
			return m_isPlaying;
		}
				
		public function stop():void
		{
			if( m_soundChannel )
				m_soundChannel.stop();
				
			onSoundComplete();
		}
	}
}