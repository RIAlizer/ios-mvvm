## ￼￼￼￼￼￼￼Coding Style and Conventions
Coding conventions are based on the Ray Wenderlich style guide here:
[http://www.raywenderlich.com/62570/objective-c-style-guide](http://www.raywenderlich.com/62570/objective-c-style-guide)__Language__
 UK english will be used.
__Spacing__
Indentations are set at 4 spaces, not tabs. This should be the default setting in Xcode.
Braces for if/else/switch/while must always go on their own line, and should line up vertically.
			if(condition)		{		... 		}		else if(some other condition)
		{
		... 
		}
		else 
		{
		... 
		}
__Naming__
All constants should be camel case and prepended by a lowercase k, followed by the project class prefix and camel case constant name. 
Acronyms should always be capitalized.

	static NSString * const kCRAssetRepoBaseURL;	static NSString * const kCRAPIBaseQAAPIURL;#### Internal Conventions__Compiler Warning Tags__
The following tags found anywhere in source files will appear as a compiler warning:* __HACK__* __TODO__* __FIXME__* __???__* __!!!__

__Logging__
Use the DDLog macros as they will be removed from final build product depending on which macro is used. DDLogError* ￼__DDLogError￼__
* ￼__DDLogWarn￼__
* ￼__DDLogInfo￼__
* ￼__DDLogVerbose￼__

__Testability__
Where possible these assertions should be used for testing.
[https://github.com/insanehunter/NSAssert-BackingActions/blob/master/NSAssert%2BBackingActions.h](https://github.com/insanehunter/NSAssert-BackingActions/blob/master/NSAssert%2BBackingActions.h)