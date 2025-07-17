import { createContext, useContext, useState } from "react";

export const TaskContext = createContext();

export function TaskProvider({ children, initialTasks = [], setProject }) {
  const [tasks, setTasks] = useState(initialTasks);

  const addTask = (newTask) => {
    setTasks((prev) => [...prev, newTask]);
    setProject((prev) => ({
      ...prev,
      tasks: [...prev.tasks, newTask],
    }));
  };

  return (
    <TaskContext.Provider value={{ tasks, addTask }}>
      {children}
    </TaskContext.Provider>
  );
}
