abstract class ConsChatStates {}

class ConInitialState extends ConsChatStates {}

class ConsChatChangeIcon extends ConsChatStates {}

class ConsChatRunnerText extends ConsChatStates {}

class ConsChatSucessText extends ConsChatStates {}

class ConsChatTypingText extends ConsChatStates {}

class ConsViewedMessage extends ConsChatStates {}

class ConsViewedUserMessage extends ConsChatStates {}

class ConsErrorViewedMessage extends ConsChatStates {}

class ConsErrorUserViewedMessage extends ConsChatStates {}

class ConsChatUploadAudioChatSucess extends ConsChatStates {}

class ConsChatUploadAudioChatError extends ConsChatStates {}

class ConsChatLoadAudioPlayerChatSucess extends ConsChatStates {}

class ConsChatLoadAudioPlayerChatError extends ConsChatStates {}

class ChatAudioIsPlaying extends ConsChatStates {}

class RecordingVoiceNoW extends ConsChatStates {}

class StopRecordingNow extends ConsChatStates {}

class SeekAudioState extends ConsChatStates {}

class ChangePlaying extends ConsChatStates {}

class GettinglengthAudio extends ConsChatStates {}

class StopTimerOfRecord extends ConsChatStates {}

class StartingTimerOfRecord extends ConsChatStates {}

class ChatAudioIsPause extends ConsChatStates {}

class ChangeCurrentPostLabel extends ConsChatStates {}

class WaithingToOPenAudio extends ConsChatStates {}

class ChangeTime extends ConsChatStates {}
