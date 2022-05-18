import {Router} from "express"
import authClientRouter from "./authClientRouter.js";

const router = Router();

router.use(authClientRouter);


export default router;
