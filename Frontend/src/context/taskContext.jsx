import { createContext, useContext, useState } from "react";
import { getProject } from "../utils/api";

export const TaskContext = createContext({
  tasks: [],
  addTask: () => {},
  fetchProject: () => {}
});

export function TaskProvider({ children, setProject, initialTasks = [] }) {
  const [tasks, setTasks] = useState(initialTasks);

  const addTask = (newTask) => {
    setTasks((prevTasks) => [...prevTasks, newTask]);
    setProject((prev) => ({
      ...prev,
      tasks: [...prev.tasks, newTask],
    }));
  };

  async function fetchProject(id) {
    try {
      const project = await getProject(id);
      console.log(project);
      setProject(project);
      setTasks(project.tasks)
    } catch (err) {
      setError(err.message);
    }
  }

  return (
    <TaskContext.Provider value={{ tasks, addTask, fetchProject }}>
      {children}
    </TaskContext.Provider>
  );
}
