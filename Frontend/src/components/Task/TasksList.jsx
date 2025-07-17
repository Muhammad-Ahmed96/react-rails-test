import { useContext, useState } from "react"
import Task from "./Task"
import RomanNumerals from 'roman-numerals'
import AddTask from "./AddTask"
import { TaskContext } from "../../context/taskContext"


export default function TasksList({ project, handleAddTask }) {
  const [addTask, setAddTask] = useState(false);
  const { tasks } = useContext(TaskContext);
  return <>
    <div className="d-flex align-items-center gap-4">
      <h2>Tasks</h2>
      <button className="btn btn-primary btn-sm" onClick={() => setAddTask(!addTask)}>Add Task</button>
    </div>
    { addTask && <AddTask toggleAddTask={setAddTask} /> }
    <div className="list-group">
      { tasks.length == 0 && <p>No Tasks Assigned yet</p>}
      {
        tasks.map((task, index) => {
          return <Task {...task} key={task.index} index={index} />
        })
      }
      {
        tasks.length > 0 && <div className="list-group-item">
          <span>{ RomanNumerals.toRoman(project.tasks.length + 1) }. </span>
          <strong>Total Time on Tasks: </strong>
          <span>{project.total_time}</span>
        </div>
      }
    </div>
  </>
}