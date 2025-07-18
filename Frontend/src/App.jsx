import { Route, Routes } from 'react-router-dom'
import ProjectsList from './components/Project/ProjectsList'
import AdminProjectsList from './components/Admin/ProjectsList'
import ProjectDetail from './components/Project/ProjectDetails'
import Login from './components/Auth/Login'
import RolesRoutes from './components/Shared/RolesRoutes'
import ProjectsRedirect from './components/Shared/ProjectsRedirect'

function App() {
  return (
    <>
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route path="/" element={<ProjectsRedirect />} />
      <Route path="/admin/projects" element={
        <RolesRoutes role="admin">
          <AdminProjectsList />
        </RolesRoutes>} 
      />
      <Route path="/projects" element={
        <RolesRoutes role="user">
          <ProjectsList />
        </RolesRoutes>}
      />
      <Route path="/projects/:id" element={<ProjectDetail />} />
      <Route path="*" element={<h1>Page Not Found!</h1>} />
    </Routes>
    </>
  )
}

export default App;
