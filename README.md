# 🔣 MuVY Programming Language

**MuVY** is a custom-built programming language designed to perform arithmetic, boolean, and string operations using structured grammar, parse trees, and evaluation logic in **Prolog**. It supports control structures like conditionals and loops and was developed using **SWISH Prolog**.

> Developed by **SER-502 Team-19**  
> Contributors: Harsha Vardhan Mupparaju, Kethan Sai Pavan Yeddla, Pavithra Moravaneni, Vishnu Teja Vantukala, Vishwanath Reddy Yasa

## 🚀 Features

- 📦 Primitive data types: `int`, `boolean`, `string`
- ➕ Arithmetic operations: `+`, `-`, `*`, `/`
- 🔁 Iteration: `for`, `while`, `for-in-range`
- ✅ Conditional logic: `if`, `if-else`, `ternary`
- 🔀 Assignment, Increment (`++`), Decrement (`--`)
- 🔍 Relational operators: `==`, `!=`, `<`, `>`, `<=`, `>=`
- 🧠 Evaluator using Prolog logic rules
- 🌳 AST / Parse Tree Generator
- 📂 File Extension: `.mvy` (Custom source code)

---

## 🛠 Tools Used

- [SWISH Prolog](https://swish.swi-prolog.org/) – Online Prolog Environment
- Prolog – Compiler, Parser, Evaluator
- `.sp` – Intermediate parse tree representation
- `.mvy` – Source code files

---

## 📂 Folder Structure
 ├── muvyTreeGenerator.pl # Parse Tree / AST Generator 
 ├── muvyEvaluator.pl # Evaluator for semantic execution ├── arithmeticOperations.mvy # Sample MVY source file 
 ├── SER-502_Team-19-ppt.pdf # Project presentation


---

## 🧪 How It Works

### Step 1: Install SWISH Prolog

Install [SWISH Prolog](https://www.swi-prolog.org/) or use it online.

---

### Step 2: Clone this repository

bash
git clone https://github.com/your-username/muvy-language
cd muvy-language

Step 3: Compile & Run
Open SWI-Prolog terminal:

bash
swipl

Load the parse tree generator and evaluator:

prolog
consult('muvyTreeGenerator.pl').     % Parse Tree
consult('muvyEvaluator.pl').         % Evaluator
✔ This will generate the parse tree and execute the result.

🔔 Note: Make sure .mvy files are in the same directory as your .pl files.
🎥 Demo
📺 Watch Demo on YouTube https://www.youtube.com/watch?v=Cyc4QD2lxjw

📚 License
This project is developed as part of the SER-502: Advanced Programming Languages course. All rights reserved by the contributors for academic use.
