# CoreAnimator

Easily way to bridge UIView animation and CoreAnimation

## Usage

Currently only sequence animation support.

```swift
SequenceAnimator()
    .add(duration: 1, view: redView) {
        // Execute `animate()` as a trigger
        $0.alpha = 1
    }
    .add(duration: 2, view: blueView) {
        // Run after 1 second.
        $0.frame.origin = .zero
    }
    // Run after UIView animations
    .add(
        duration: 1,
        layer: yellowView.layer,
        options: .easeInOut,
        keyPath: KeyPathValue.cornerRadius.self,
        fromValue: 0,
        toValue: 20
    )
    .addCompletion {
        // Calling when all animation end.
        print("end")
    }
    .animate()
```


## TODO
- [ ] Support Parallel
- [ ] Support Cocoapods
- [ ] Support Carthage
- [ ] Write Unit test.

## License
CoreAnimator is available under the MIT license. See the LICENSE file for more info.



