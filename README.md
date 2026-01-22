# Automated Tamagotchi Domain (PDDL)

## Overview
This project implements an **automated Tamagotchi simulator** using **PDDL (Planning Domain Definition Language)**. The domain models a virtual pet that autonomously manages its needs—such as hunger, sleepiness, and happiness—using **temporal processes, events, and numeric fluents**.

The goal is to demonstrate how AI planning can be used to model continuous behavior, mode switching, and resource management over time.

---

## Domain Description
The Tamagotchi exists in two locations:
- **bed** – used for sleeping and recovery  
- **kitchen** – used for feeding  

The Tamagotchi switches between behavioral modes automatically and must maintain balanced internal states in order to successfully complete the simulation.

---

## Key Features
- **Numeric fluents** to model hunger, sleepiness, and unhappiness  
- **Temporal processes** that continuously update the Tamagotchi’s state over time  
- **Events** that automatically switch behavioral modes based on a global timer  
- **Actions** for movement and task completion  
- **Goal condition** that ends the simulation when the Tamagotchi is healthy, rested, and happy  

---

## Behavioral Modes
- **Feed Mode:** Reduces hunger and unhappiness, increases sleepiness  
- **Sleep Mode:** Reduces sleepiness and unhappiness, increases hunger  

A global countdown timer controls when the Tamagotchi switches between modes.

---

## Actions
- `move` – Moves the Tamagotchi between locations  
- `finish` – Ends the simulation when all needs are sufficiently satisfied  

---

## Goal
The simulation completes successfully when the Tamagotchi:
- is alive  
- has low hunger  
- has low sleepiness  
- has low unhappiness  

---

## Purpose
This domain was created to explore **temporal planning, automated behavior, and numeric state modeling** in PDDL, inspired by the classic Tamagotchi virtual pet.
