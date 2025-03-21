import { Request, Response, Router } from "express";


export class AuthRoutes {


    static get routes(): Router {

        const router = Router();

        router.get('/renew', (req: Request, res: Response ) => {

            res.json({msg: "prueba"})
        });

        return router;
    }


}