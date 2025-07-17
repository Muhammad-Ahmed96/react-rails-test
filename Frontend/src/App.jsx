import { Route, Routes } from 'react-router-dom'
import Projects from './components/Project/Projects'
import ProjectDetail from './components/Project/ProjectDetails'
import Login from './components/Auth/Login'
import PrivateRoutes from './context/PrviateRoutes'
import Navbar from './components/Shared/Navbar'

function App() {
  return (
    <>
    <Routes>
      <Route path="/login" element={<Login />} />
      <Route element={<PrivateRoutes />}>
        <Route path="/" element={<Projects />} />
        <Route path="/projects/:id" element={<ProjectDetail />} />
      </Route>
    </Routes>
    </>
  )
}

export default App;
