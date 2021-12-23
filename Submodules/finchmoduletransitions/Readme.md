# ⚜️ Finch Module Transitions

Данный фраемворк содержит DI компоненты и всевозможные функции/расширения, направленные на навигацию.

## 🛠 Установка

Встраивается в проект приложения как submodule

[Как добавить submodule в проект](https://www.notion.so/finchmoscow/submodule-98e7f8b8ed0542949d4c793590ffcc25)

## ⚡️ Список компонентов

### Assembly 

[Assembly](https://git.finch.fm/frameworks/finchmoduletransitions/blob/master/FinchModuleTransitions/Core/Assembly.swift) - Протокол направленный на DI через Assembly классы 

### ModuleTransitionHandler

[ModuleTransitionHandler](ModuleTransitionHandler) - Протокол для UIViewController, позволяющий закрывать view в Router. Позволяет осузествлять переходы между модулями через тип его Assembly

### TransitionModel
[TransitionModel](https://git.finch.fm/frameworks/finchmoduletransitions/blob/master/FinchModuleTransitions/Core/TransitionModel.swift) - Протокол для модели, используемой в Assebly