import './App.css';
import Topnavbar from './TopNavbar';
import {
  BrowserRouter as Router,
  Routes,
  Route,
  Link} from "react-router-dom";
import Anggota from './Anggota';
import Shu from './Shu';

function App() {
  return (
    <div className="hk-wrapper" data-layout="navbar" data-layout-style="default" data-menu="light" data-footer="simple">
      <Router>
        <Topnavbar />
        <Routes>
            <Route path="/anggota" element={<Anggota/>} />
            <Route path="/shu" element={<Shu/>} />
        </Routes>
      </Router>
    </div>
  );
}

export default App;
