import { useContext, useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { getProject } from '../../utils/api';
import AssignProject from './AssignProject';
import ProjectAssignees from './ProjectAssignees';
import ErrorMsg from './ErrorMsg';
import { AuthContext } from '../../context/authContext';
import TasksList from '../Task/TasksList';
import { TaskProvider } from '../../context/taskContext';

export default function ProjectDetail() {
  const { id } = useParams();
  const { token } = useContext(AuthContext);
  const [project, setProject] = useState(null);
  const [error, setError] = useState(null);
  const [loading, setLoading] = useState(true);
  const [projectUsers, setProjectUsers] = useState([]);

  useEffect(() => {
    async function fetchProject(id) {
      try {
        const project = await getProject(id);
        console.log(project);
        setProject(project);
        setProjectUsers(project.users)
      } catch (err) {
        setError(err.message);
      } finally {
        setLoading(false);
      }
    }

    fetchProject(id);
  }, [id]);

  async function assignProjectToUser(projectId, userId) {
    const response = await fetch(`http://localhost:3000/admin/projects/${projectId}/assign-project`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        user_id: userId
      })
    })
    const data = await response.json()
    if(!response.ok) {
      setError(data.error)
      return;
    }
    setProjectUsers(oldUsers => {
      return [...oldUsers, {id: data.id, name: data.name}]
    })
  }

  async function removeUserFromProject(projectId, userId) {
    const response = await fetch(`http://localhost:3000/admin/projects/${projectId}/unassign-project`, {
      method: 'POST',
      headers: {
        'Authorization': `Bearer ${token}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        user_id: userId
      })
    })
    const data = await response.json()
    if(!response.ok) {
      setError(data.error)
      return;
    }
    setProjectUsers(oldUsers => {
      const fileteredUsers = oldUsers.filter(u => u.id !== userId)
      return fileteredUsers;
    })
  }

  if (loading) return <p>Loading...</p>;
  if (!project) return <p>No project found.</p>;

  return (
    <TaskProvider initialTasks={project.tasks} setProject={setProject}>
      <div className="container mt-4">
        <div className="card">
          <div className='card-header'>
            <h2>Project: {project.name}</h2>
          </div>
          <div className='card-body'>
            { error && <ErrorMsg msg={error} /> }
            <p><strong>Start Date:</strong> {project.start_date}</p>
            <p><strong>Duration:</strong> {project.duration} days</p>
            <ProjectAssignees projectId={id} users={projectUsers} removeUserFromProject={removeUserFromProject} />
            <AssignProject project_id={id} assignProjectToUser={assignProjectToUser} />
            <br />
            <TasksList tasks={project.tasks} project={project} />
          </div>
        </div>
      </div>
    </TaskProvider>
  );
}
