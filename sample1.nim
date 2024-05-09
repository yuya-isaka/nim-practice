type SampleObject = object
  sampleProp: string

proc doSome(self: SampleObject): string = self.sampleProp & "!!"

let sample = SampleObject(sampleProp: "Hello")

echo doSome(sample)
echo sample.doSome()
echo sample.doSome

type Animal = ref object of RootObj
method sound(self: Animal): string {.base.} = ""

type Duck = ref object of Animal
method sound(self: Duck): string = "< quack"

type Dog = ref object of Animal
method sound(self: Dog): string = "< bow"

for animal in @[new Duck, new Dog]:
  echo animal.sound

type Soundable = object
  soundProc: proc(): string

proc sound(self: Soundable): string = self.soundProc()

proc soundAll(soundables: seq[Soundable]) =
  for s in soundables:
    echo s.sound

import std/sugar

proc asSoundable(self: Animal): Soundable =
  Soundable(soundProc: () => self.sound)

var s: Soundable = (new Duck).asSoundable
echo s.sound
s = (new Dog).asSoundable
echo s.sound

import std/sequtils

@[new Duck, new Dog].map(asSoundable).soundAll